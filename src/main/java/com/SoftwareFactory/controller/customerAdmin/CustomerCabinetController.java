
package com.SoftwareFactory.controller.customerAdmin;


import com.SoftwareFactory.comparator.CaseByStatusAndDateComparator;
import com.SoftwareFactory.comparator.MessageByDateComparator;
import com.SoftwareFactory.comparator.ProjectByDateComparator;
import com.SoftwareFactory.constant.MainPathEnum;
import com.SoftwareFactory.constant.MessageEnum;
import com.SoftwareFactory.constant.StatusEnum;
import com.SoftwareFactory.model.*;
import com.SoftwareFactory.service.*;
import com.SoftwareFactory.util.SaveFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/cabinet")
@SessionAttributes("roles")
public class CustomerCabinetController {

    @Autowired
    CustomerInfoService customerInfoService;

    @Autowired
    MessageService messageService;

    @Autowired
    ProjectService projectService;

    @Autowired
    CaseService caseService;

    @Autowired
    ManagerInfoService managerInfoService;

    @Autowired
    UserService userService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView getCustomerCabinet(HttpSession httpSession) {

        System.out.println("cabinet");

        ModelAndView customerCabinet = new ModelAndView("customerAdminViews/customerCabinet");

        Set<Project> projectsToShow = addGeneralDataToMAVAndReturnProjects(customerCabinet , httpSession);
        ArrayList<Case> casesToShow = new ArrayList<>();

        if (projectsToShow != null) {

            // GET CASES FROM PROJECT
            Iterator<Project> projectIterator = projectsToShow.iterator();
            while (projectIterator.hasNext()) {
                Project project = projectIterator.next();
                getCasesFromProject(project, casesToShow);
            }
        }

        // SORT CASE
        Collections.sort(casesToShow, new CaseByStatusAndDateComparator());

        //PUT OBJECTS TO MODEL
        customerCabinet.addObject("currentProjectCasesName" , "All Cases");
        customerCabinet.addObject("cases", casesToShow);

        return customerCabinet;
    }

    @RequestMapping(value = "/newCase", method = RequestMethod.GET)
    public ModelAndView newCase(HttpSession httpSession ) {

        ModelAndView customerCabinet = new ModelAndView("customerAdminViews/customerCase");

        int userId = (Integer) httpSession.getAttribute("UserId");
        CustomerInfo customerInfo = customerInfoService.getCustomerInfoById((long)userId);

        Set<Project> projectsToShow = customerInfo.getProjects();

        List<Project> sortedProjectListToShow = new ArrayList<>(projectsToShow);
        Collections.sort(sortedProjectListToShow, new ProjectByDateComparator());

        //PUT OBJECTS TO MODEL
        customerCabinet.addObject("customerName" , customerInfo.getName());
        customerCabinet.addObject("projects", sortedProjectListToShow);

        return customerCabinet;
    }

    @RequestMapping(value = "/createCase", method = RequestMethod.POST)
    public ModelAndView createCase(HttpSession httpSession, @RequestParam("projectName") String projectName,
                                   @RequestParam("caseName") String caseName,
                                   @RequestParam("message") String message, @RequestParam("language") String language,
                                   @RequestParam("fileCase[]") MultipartFile[] files,
                                   @RequestParam(value = "emergency", required = false) boolean emergency){

        System.out.print(projectName + " " + " " + caseName + " " + message + " " + " " + language);


        //===================================================
        Long userId = new Long((Integer)httpSession.getAttribute("UserId"));
        CustomerInfo customerInfo = customerInfoService.getCustomerInfoById(userId);

        Set<Project> projects = customerInfo.getProjects();

        Project project = null;
        if (projects != null){
            Iterator<Project> itr = projects.iterator();
            while (itr.hasNext()) {
                project = itr.next();
                if(project.getProjectName().equals(projectName)){
                    break;
                }
            }
        }
        Case newCase = new Case();
        newCase.setProject(project);
        newCase.setProjectTitle(caseName);
        newCase.setStatus(StatusEnum.OPEN.toString());
        Date date = new Date();
        newCase.setCreationDate(date);
        newCase.setUserManagerId(0L); // <======MUST BE MANAGER ID
        newCase.setLanguage(language);
        newCase.setEmergency(emergency);

        Set<Case> caseSet = project.getCases();
        caseSet.add(newCase);
        project.setCases(caseSet);
        projectService.updateProject(project);
        Case caseCreated = caseService.getCaseById(newCase.getId());
        Set<Message> messages = caseCreated.getMessages();
        Message msg = new Message();
        msg.setaCase(caseCreated);
        User us = userService.findById(userId.intValue());
        msg.setUser(us);
        msg.setMessageTime(date);
        msg.setMessageText(message);

        msg.setIsRead(MessageEnum.NOTREAD.toString());

        messages.add(msg);
        messageService.addNewMessage(msg);
        caseCreated.setMessages(messages);
        caseService.updateCase(caseCreated);

        if(!files[0].isEmpty()){
            String pathToSaveFile = "/case/" + project.getId() + "/"+ newCase.getId() + "/" + msg.getId();
            SaveFile sf = new SaveFile(pathToSaveFile, files);
            sf.saveFile();
            msg.setMessagePath(MainPathEnum.mainPath + pathToSaveFile);
            messageService.updateMessage(msg);
        }

        ModelAndView modelAndView = new ModelAndView("redirect:/list");
        return modelAndView;
    }


    @RequestMapping (value = "/case/{id}/print_message", method = RequestMethod.POST)
    public ModelAndView casePrintMessageController( @PathVariable Long id, @RequestParam("message") String messageText,
                                                    @RequestParam("file[]") MultipartFile[]  files, HttpSession httpSession,
                                                    @RequestParam(value = "emergency", required = false) boolean emergency){

        // GET
        Case aCase = caseService.getCaseById(id);
        int userId = (Integer) httpSession.getAttribute("UserId");
        User currentUser = userService.findById(userId);

        aCase.setEmergency(emergency);

        // CREATE MESSAGE
        Message message = new Message();
        message.setaCase(aCase);

        message.setUser(currentUser);
        message.setMessageTime(new Date());
        message.setMessageText(messageText);
        message.setIsRead(MessageEnum.NOTREAD.toString());
        messageService.addNewMessage(message);

        // SAVE MESSAGE TO CASE
        Set <Message> messages = aCase.getMessages();
        messages.add(message);
        aCase.setMessages(messages);

        //SAVE FILE
        if(!files[0].isEmpty()){
            System.out.println("=======FILE LENGTH NOT NULL " + files.length);
            String pathToSaveFile = "/case/" + aCase.getProject().getId() + "/"+ aCase.getId() + "/" + message.getId();
            SaveFile sf = new SaveFile(pathToSaveFile, files);
            sf.saveFile();
            message.setMessagePath(MainPathEnum.mainPath + pathToSaveFile);
            messageService.updateMessage(message);
        } else {
            System.out.println("=======FILE LENGTH NULL");
        }

        caseService.updateCase(aCase);

        // REDIRECT TO CHAT
        String redirectLink = "redirect:/cabinet/case/" + id;

        return new ModelAndView(redirectLink);
    }

    @RequestMapping (value = "/case/{id}/close_case", method = RequestMethod.POST)
    public ModelAndView caseCloseController( @PathVariable Long id) {

        Case caseToClose = caseService.getCaseById(id);
        caseToClose.setStatus(StatusEnum.CLOSE.toString());
        caseService.updateCase(caseToClose);

        return new ModelAndView("redirect:/cabinet/");
    }




   /* @RequestMapping(value = "/project/{id}", method = RequestMethod.GET)
    public ModelAndView getProjectCases(@PathVariable Long id, HttpSession httpSession) {

        // GET CASES FROM PROJECT BY ID
        ModelAndView customerCabinetShowOneProject = new ModelAndView("customerAdminView/customerCabinet");

        addGeneralDataToMAVAndReturnProjects(customerCabinetShowOneProject , httpSession);

        ArrayList<Case> casesToShow = new ArrayList<>();

        Project project = projectService.getProjectById(id);
        getCasesFromProject(project, casesToShow);

        //SORT PROJECT & CASE
        Collections.sort(casesToShow, new CaseByStatusAndDateComparator());


        //GET PROJECT NAME
        String projectName = "";
        if (project.getProjectName().equals("#$GENERAL")){
            projectName = "Discussion Room";
        } else {
            projectName = project.getProjectName();
        }

        //PUT OBJECTS TO MODEL

        customerCabinetShowOneProject.addObject("currentProjectCasesName" , projectName);
        customerCabinetShowOneProject.addObject("projectId" , Long.toString(project.getId()));
        customerCabinetShowOneProject.addObject("cases", casesToShow);

        return customerCabinetShowOneProject;
    }*/

    @RequestMapping(value = "/case/{id}", method = RequestMethod.GET)
    public ModelAndView caseChatController(@PathVariable Long id, HttpSession httpSession) {

        ModelAndView caseChat = new ModelAndView("customerAdminViews/customerChat");

        addGeneralDataToMAVAndReturnProjects(caseChat , httpSession);


        // GET MESSAGE FROM CASE BY ID
        Case aCase = caseService.getCaseById(id);
        Set<Message> messagesUnsorted = aCase.getMessages();
        List<Message> messagesSorted = new ArrayList<>(messagesUnsorted);

        MessageByDateComparator messageByDateComparator = new MessageByDateComparator();

        // SORT BY DATE
        Collections.sort(messagesSorted, messageByDateComparator);

        //PUT OBJECTS TO MODEL
        caseChat.addObject("messagesSorted", messagesSorted);
        caseChat.addObject("caseId", id);
        caseChat.addObject("case", aCase);
        caseChat.addObject("caseStatus" , aCase.getStatus());
        caseChat.addObject("managerInfo" , managerInfoService.getManagerInfoById(aCase.getUserManagerId()));
        return caseChat;
    }

    @RequestMapping (value = "/case/{id}/answer", method = RequestMethod.GET)
    public ModelAndView caseAnswerController( @PathVariable Long id) {

        ModelAndView caseAnswerChat = new ModelAndView("customerAdminViews/customerChatAnswer");

        Case aCase = caseService.getCaseById(id);
        Set<Message> messages = aCase.getMessages();

        caseAnswerChat.addObject("caseId", id);
        caseAnswerChat.addObject("case" , aCase);
        caseAnswerChat.addObject("messages" , messages);

        return caseAnswerChat;
    }

    //ADD GENERAL OBJECT THAT PERSIST IN ALL JSP
    private Set<Project>  addGeneralDataToMAVAndReturnProjects(ModelAndView modelAndView , HttpSession httpSession){

        Long userId = new Long((Integer) httpSession.getAttribute("UserId"));
        CustomerInfo customerInfo = customerInfoService.getCustomerInfoById(userId);

        String customerName = customerInfo.getName();

        Set<Project> projectsToShow = customerInfo.getProjects();

        List<Project> sortedProjectListToShow = new ArrayList<>(projectsToShow);
        Collections.sort(sortedProjectListToShow, new ProjectByDateComparator());

        //PUT OBJECTS TO MODEL
        modelAndView.addObject("customerName" , customerName);
        modelAndView.addObject("projects", sortedProjectListToShow);

        return projectsToShow;
    }

    //PUT ALL CASES FROM PROJECTS TO ONE ARRAY;
    private void getCasesFromProject(Project project, ArrayList<Case> casesToShow) {

        Set<Case> cases = project.getCases();

        if (cases != null) {
            Iterator<Case> caseIterator = cases.iterator();
            while (caseIterator.hasNext()) {
                Case aCase = caseIterator.next();
                casesToShow.add(aCase);
            }
        }
    }
}