package com.project.unicon.board.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Message_Mapper;
import com.project.unicon.vo.Message_Box_VO;

@Service("Message_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Message_Service_Impl implements Message_Service{
	@Autowired
	private Message_Mapper message_Mapper;
	
	@Override
	public void insertMessage(Message_Box_VO message_Box_VO) throws Exception{
		message_Mapper.messageInsert(message_Box_VO);
	}

	@Override
	public int countRemainMessage(String id) throws Exception {
		return message_Mapper.countRemainMessage(id);
	}

	@Override
	public List<Message_Box_VO> lookMessage(String id) throws Exception {
		return message_Mapper.lookMessage(id);
	}

	@Override
	public void delMessage(String id, int messageNum) throws Exception {
		message_Mapper.delMessage(id, messageNum);
	}

	@Override
	public List<Message_Box_VO> lookSendMessage(String send_id) throws Exception {
		return message_Mapper.lookSendMessage(send_id);
	}

	@Override
	public void delSendMessage(String send_id, int messageNum) throws Exception {
		System.out.println("뚜찌빠찌");
		message_Mapper.delSendMessage(send_id, messageNum);
	}

	@Override
	public Message_Box_VO detailMessage(String id, int messageNum) throws Exception {
		message_Mapper.updateDetailMessage(id, messageNum);
		return message_Mapper.detailMessage(id, messageNum);
	}

	@Override
	public Message_Box_VO detailSendMessage(String send_id, int messageNum) throws Exception {
		return message_Mapper.detailSendMessage(send_id, messageNum);
	}

	@Override
	public String replyMessage(String id, int messageNum) throws Exception {
		return message_Mapper.replyMessage(id, messageNum);
	}
	
	@Override
	public String searchIdUsingNick(String nickname) throws Exception {
		return message_Mapper.searchIdUsingNick(nickname);
	}
	
}
