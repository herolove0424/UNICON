package com.project.unicon.board.Service;

import java.util.List;

import com.project.unicon.vo.Message_Box_VO;

public interface Message_Service {
	
	public void insertMessage(Message_Box_VO message_Box_VO) throws Exception;
	public int countRemainMessage(String id) throws Exception;
	public List<Message_Box_VO> lookMessage(String id) throws Exception;
	public void delMessage(String id, int messageNum) throws Exception;
	public List<Message_Box_VO> lookSendMessage(String send_id) throws Exception;
	public void delSendMessage(String send_id, int messageNum) throws Exception;
	public Message_Box_VO detailMessage(String id, int messageNum) throws Exception;
	public Message_Box_VO detailSendMessage(String send_id, int messageNum) throws Exception;
	public String replyMessage(String id, int messageNum) throws Exception;
	public String searchIdUsingNick(String nickname) throws Exception;
}
