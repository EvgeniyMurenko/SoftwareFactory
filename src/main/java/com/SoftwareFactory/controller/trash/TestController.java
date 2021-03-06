
package com.SoftwareFactory.controller.trash;

import com.SoftwareFactory.comparator.MessageByDateComparator;
import com.SoftwareFactory.constant.GlobalEnum;
import com.SoftwareFactory.constant.ProjectEnum;
import com.SoftwareFactory.constant.RoleEnum;
import com.SoftwareFactory.constant.StatusEnum;
import com.SoftwareFactory.model.*;
import com.SoftwareFactory.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Date;
import java.util.*;


@Controller
@SessionAttributes("roles")
public class TestController {


    @Autowired
    CustomerInfoService customerInfoService;

    @Autowired
    CaseService caseService;

    @Autowired
    MessageService messageService;


    @Autowired
    ProjectService projectService;

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public ModelAndView test() {
        System.out.println("============test");
        System.out.println("============estimate " + ProjectEnum.projectNameEstimate.getDbValue());
        System.out.println("============normal " + ProjectEnum.projectNameNormal.getDbValue());

        /*List<Case> cases = caseService.getAllCases();
        Case aCase = cases.get(0);
        Set<Message> messages = aCase.getMessages();
        System.out.println("messages" + messages);
        String status = aCase.getStatus();
        System.out.println(status);
        if (messages == null) {
            System.out.println("messages null");
        }
        Iterator<Message> iterator = messages.iterator();

        while (iterator.hasNext()) {
            Message message = iterator.next();
            System.out.println(message.getMessageText());
        }*/
        ModelAndView modelAndView = new ModelAndView("redirect:/");
        return modelAndView;
    }

  /*  @RequestMapping(value = "/test1", method = RequestMethod.GET)
    public ModelAndView test1() {
        System.out.println("test1");
        List<CustomerInfo> customerInfos = customerInfoService.getAllCustomerInfos();
        CustomerInfo customerInfo = customerInfos.get(0);
        Set<Project> projects = customerInfo.getProjects();
        if (projects == null) {
            System.out.println("projects null");
        }
        Iterator<Project> iterator = projects.iterator();
        while (iterator.hasNext()) {
            Project project = iterator.next();
            System.out.println(project.getProjectName());
            System.out.println(project.getCustomerInfo().getUserId());
        }
        ModelAndView modelAndView = new ModelAndView("redirect:/");
        return modelAndView;
    }

    @RequestMapping(value = "/test2", method = RequestMethod.GET)
    public ModelAndView test2() {
        System.out.println("============test2");
        List<CustomerInfo> customerInfos = customerInfoService.getAllCustomerInfos();
        CustomerInfo customerInfo = customerInfos.get(1);
        System.out.println("======customerInfo name: " + customerInfo.getFirstName());
        System.out.println("====== cu");
        Set<Project> projects = customerInfo.getProjects();
        if (projects == null) {
            System.out.println("projects null");
        }
        Iterator<Project> iterator = projects.iterator();
        while (iterator.hasNext()) {
            Project project = iterator.next();
            System.out.println(project.getProjectName());
            // System.out.println(project.getCases().get);
        }
        ModelAndView modelAndView = new ModelAndView("redirect:/");
        return modelAndView;
    }
*/

    @Autowired
    UserService userService;


/*

    @RequestMapping(value = "/createCustomer", method = RequestMethod.GET)
    public ModelAndView createCustomer() {

        // CREATE USER WITH ROLE CUSTOMER

        String emailSSO = "test22@mail.com";
        String password = "1111";

        User user = new User();

        user.setPassword(password);
        user.setEmail(emailSSO);
        user.setSsoId(emailSSO);

        UserProfile userProfile = new UserProfile();
        userProfile.setId(1);
        userProfile.setType("CUSTOMER");

        Set<UserProfile> userProfiles = new HashSet<>();
        userProfiles.add(userProfile);

        user.setUserProfiles(userProfiles);

        userService.saveUser(user);

        // CREATE CUSTOMER PROFILE

        User userAfterSave = userService.findBySSO(emailSSO);

        Long userId = new Long(userAfterSave.getId());
        String firstName = "test";
        String lastName = "test";
        String company = "test";
        String avatar = "test";


        //CREATE FINAL NEW CUSTOMER
        Set<Project> projects = new HashSet<>();

        CustomerInfo customerInfo = new CustomerInfo(userId, firstName, lastName, company, avatar, projects);
        customerInfoService.addNewCustomerInfo(customerInfo);


        CustomerInfo customerInfoCreated = customerInfoService.getCustomerInfoById(userId);


        //CREATE #$GENERAL PROJECT FOR CUSTOMER
        Date projectCreationDate = new Date(1990, 12, 13);

        Set<Case> cases = new HashSet<>();


        Project project = new Project("#$GENERAL", projectCreationDate, StatusEnum.OPEN.toString(), customerInfo, cases, "test");

        Set<Project> projectsToAdd = new HashSet<>();
        projectsToAdd.add(project);
        customerInfoCreated.setProjects(projectsToAdd);


        customerInfoService.updateCustomerInfo(customerInfoCreated);

        return new ModelAndView("views");
    }

*/

    @Autowired
    MailService mailService;

    @RequestMapping(value = "/testSendMail")
    public void send (){
        mailService.sendEmailAfterRegistration("123" , "login" , "o.grument@gmail.com" , "name");
    }

    @RequestMapping(value = "/createAdmin", method = RequestMethod.GET)
    public void createAdmin() {
        String emailSSO = randomeSSO();
        String password = "123";

        if (checkSSo(emailSSO)) {
            User user = new User();
            user.setPassword(password);
            //user.setEmail(emailSSO);
            user.setSsoId(emailSSO);

            UserProfile userProfile = new UserProfile();
            userProfile.setType(RoleEnum.ADMIN.toString());
            userProfile.setId(getTypeID(userProfile.getType()));

            Set<UserProfile> userProfiles = new HashSet<>();
            userProfiles.add(userProfile);

            user.setUserProfiles(userProfiles);

            userService.saveUser(user);
        } else {
            createAdmin();
        }
    }

    public void createManager() {
        String emailSSO = randomeSSO();
        String password = "123";

        if (checkSSo(emailSSO)) {
            User user = new User();
            user.setPassword(password);
            //user.setEmail(emailSSO);
            user.setSsoId(emailSSO);

            UserProfile userProfile = new UserProfile();
            userProfile.setType(RoleEnum.MANAGER.toString());
            userProfile.setId(getTypeID(userProfile.getType()));

            Set<UserProfile> userProfiles = new HashSet<>();
            userProfiles.add(userProfile);
            user.setUserProfiles(userProfiles);

            userService.saveUser(user);

            User userAfterSave = userService.findBySSO(emailSSO);

            Long userId = new Long(userAfterSave.getId());
            String firstName = randomeSSO();
            String lastName = randomeSSO();

            //code to create manager must be here


            CustomerInfo customerInfoCreated = customerInfoService.getCustomerInfoById(userId);


        } else {
            createManager();
        }
    }

    private String randomeSSO() {
        String str = "qwertyuiopasdfghjklzxcvbnm";
        String strSso = "";
        for (int i = 0; i < 4; i++) {
            int value = (int) (Math.random() * str.length() - 1);
            strSso += str.charAt(value);
        }
        return strSso + "@mail.com";
    }

    private boolean checkSSo(String nameSSO) {
        if (userService.findBySSO(nameSSO) == null) {
            return true;
        }
        return false;
    }

    private int getTypeID(String str) {
        switch (str) {
            case "ADMIN":
                return 2;
            case "CUSTOMER":
                return 1;
            case "MANAGER":
                return 3;
            case "STAFF":
                return 4;
        }
        return -1;
    }



    @Autowired
    StaffInfoService staffInfoService;

    @RequestMapping(value = "/q", method = RequestMethod.GET)
    public void test3() {
        System.out.println("==============test create staff");

        User user = new User();
        user.setPassword("123");
        user.setSsoId("mr_jeka");
        UserProfile userProfile = new UserProfile();
        userProfile.setType(RoleEnum.STAFF.toString());
        userProfile.setId(getTypeID(userProfile.getType()));
        Set<UserProfile> userProfiles = new HashSet<>();
        userProfiles.add(userProfile);
        user.setUserProfiles(userProfiles);
        userService.saveUser(user);

        Set<MessageTask> messageTasks = new HashSet<>();
        Set<GoogleCloudKey> googleCloudKeys = new HashSet<>();


        StaffInfo staffInfo = new StaffInfo();
        staffInfo.setUser((long)user.getId());
        staffInfo.setName("Murenko Evgeniy");
        staffInfo.setPhone("0939091062");
        staffInfo.setEmail("mr_jeka@bk.ru");
        staffInfo.setBirthday(new java.util.Date(5, 7, 1989));


        staffInfo.setMessageTasks(messageTasks);
        staffInfo.setGoogleCloudKeys(googleCloudKeys);

       staffInfoService.addStaffInfo(staffInfo);



        System.out.println("======== FINISH ==========");

    }
}

