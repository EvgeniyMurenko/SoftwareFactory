package com.SoftwareFactory.dao;

import com.SoftwareFactory.model.MessageTask;
import com.SoftwareFactory.model.StaffInfo;

import java.util.List;

public interface MessageTaskDao {
    Long create(MessageTask messageTask);
    MessageTask read(Long id);
    void update(MessageTask messageTask);
    void delete(MessageTask messageTask);
    List<MessageTask> findAll();
    List<MessageTask> findAllMessageTaskByStaff(Long staffInfo);
}
