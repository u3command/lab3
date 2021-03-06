package jm;

import DAO.TaskDAO;
import journal.Task;
import utils.Constants;
import utils.TransferObject;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

/**
 * Part of taskmgr.
 */

public class JournalManager implements IJournalManager, Serializable {
    private Integer emp_id;
    /**
     * Creates journal manager and fills fields.
     */
    public JournalManager(Integer emp_id) {
        this.emp_id = emp_id;

    }
    public  void add(Task task)  {
        if(task != null) {
            TaskDAO.addTask(task);

        }
    }
    public  void delete(int id)  {
        TaskDAO.deleteTask(id);
    }
    @Override
    public List getCurrentTasks() {

        return TaskDAO.getCurrentTasks(emp_id);

    }
    @Override
    public List getCompletedTasks() {
        return TaskDAO.getTasks(emp_id, Constants.COMPLETED);
    }

    @Override
    public List getTasks() {
        return TaskDAO.getTasks(emp_id);
    }

    public Task get(int id) {
        return TaskDAO.getTask(id);
    }

    @Override
    public void addSubtask(int t_id, Task stask) {
        TaskDAO.addSubtask(stask);


    }

    @Override
    public void deleteSubtask(Integer t_id, Integer st_id) {

        TaskDAO.deleteSubtask(t_id,st_id);
    }

    @Override
    public Task getSubtask(Integer t_id,Integer st_id) {
        return TaskDAO.getSubtask(t_id,st_id);
    }



    @Override
    public List getSubtasks(Integer t_id,String status) {
        return TaskDAO.getCurrentSubtasks(t_id);
    }



    @Override
    public List getSubtasks(Integer t_id) {
        return TaskDAO.getSubtasks(t_id);
    }



    public void complete(int id)  {
        TaskDAO.completeTask(id);
    }
    public void cancel(int id)  {
        TaskDAO.cancelTask(id);
    }

    public List getTasks(String str)
    {
        return TaskDAO.findTasks(str,emp_id);
    }

    @Override
    public void updateTask(int t_id,TransferObject to) {

        TaskDAO.updateTask(t_id, to);
    }


    @Override
    public List searchTasks(String param) {
        return TaskDAO.findTasks(param,emp_id);
    }
    public List getEmpsTasks()
    {
        return TaskDAO.getEmpsTasks(emp_id);
    }
    public int total_count(int id)
    {

        return TaskDAO.getTotalCount(id);
    }
    public int cur_count(int id)
    {

        return TaskDAO.getCurrentCount(id);
    }
    public int comp_count(int id)
    {

        return TaskDAO.getCompletedCount(id);
    }
    public int failed_count(int id)
    {

        return TaskDAO.getFailedCount(id);
    }
    public int cancelled_count(int id)
    {

        return TaskDAO.getCancelledCount(id);
    }
}
