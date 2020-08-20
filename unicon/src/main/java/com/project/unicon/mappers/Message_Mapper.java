package com.project.unicon.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.unicon.vo.Message_Box_VO;

@Mapper
public interface Message_Mapper {
	public void messageInsert(Message_Box_VO message_Box_VO) throws Exception;
	public int countRemainMessage(String id) throws Exception;
	public List<Message_Box_VO> lookMessage(String id) throws Exception;
	public void delMessage(@Param("id") String id, @Param("messagenum") int messagenum) throws Exception;
	public List<Message_Box_VO> lookSendMessage(String send_id) throws Exception;
	public void delSendMessage(@Param("send_id") String send_id, @Param("messagenum") int messagenum) throws Exception;
	public void updateDetailMessage(@Param("id") String id, @Param("messagenum") int messagenum) throws Exception;
	public Message_Box_VO detailMessage(@Param("id") String id, @Param("messagenum") int messagenum) throws Exception;
	public Message_Box_VO detailSendMessage(@Param("send_id") String send_id, @Param("messagenum") int messagenum) throws Exception;
	public String replyMessage(@Param("id") String id, @Param("messagenum") int messagenum) throws Exception;
	public String searchIdUsingNick(@Param("nickname") String nickname) throws Exception;
}
