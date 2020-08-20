package com.project.unicon.board.Controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.unicon.board.Service.Message_Service;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.Message_Box_VO;


@Controller("Massage_Controller")
@RequestMapping("/message")
public class Massage_Controller_Impl implements Massage_Controller{
	@Autowired
	private Message_Service message_Service;
	
	@Autowired
	Message_Box_VO message_Box_VO;
	
	@GetMapping("/messageform.do")
	@Override
	public String sendMassageForm(@RequestParam("id") String id,Model model) throws Exception{
		model.addAttribute("id", id);
		return "/board/MessageForm";
	}
	
	@PostMapping("/messageSend.do")
	@Override
	//public String messageSend(@ModelAttribute("message") Message_Box_VO message,HttpServletRequest request) throws Exception{
		public ResponseEntity<String> messageSend(@ModelAttribute("message") Message_Box_VO message,HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		String id=message.getId();
		HttpSession session = request.getSession();
		Member_VO member = (Member_VO) session.getAttribute("member");
		String send_id = member.getId();
		
		String result="";
		
		message.setSend_id(send_id);
		try {
			message_Service.insertMessage(message);
			entity=new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@GetMapping("/lookMessage.do")
	@Override
	public String lookMessage(HttpServletRequest request,Model model) throws Exception {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberforBoard");
		List<Message_Box_VO> messageList = message_Service.lookMessage(id);
		model.addAttribute("messageList", messageList);
		model.addAttribute("myId", id);
		model.addAttribute("whatPage", "AllLookMessage.jsp");
		return "/board/LookMessage";
	}
	
	@GetMapping("delMessages.do")
	@Override
	public ResponseEntity<String> delMessage(@RequestParam(value = "valueArrTest[]") List<String> valueArr,HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberforBoard");
		
		ResponseEntity<String> resEnt = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			for(int i =0; i<valueArr.size();i++) {
				int messageNum=Integer.valueOf(valueArr.get(i));
				message_Service.delMessage(id, messageNum);
			}
			resEnt =  new ResponseEntity<String>("success",HttpStatus.CREATED);
			
		} catch (Exception e) {
			resEnt =  new ResponseEntity<String>("error",HttpStatus.CREATED);
			
		}
		
		return resEnt;
		
	}
	
	@GetMapping("/lookSendMessage.do")
	@Override
	public String lookSendMessage(HttpServletRequest request,Model model) throws Exception {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberforBoard");
		model.addAttribute("myId", id);
		model.addAttribute("whatPage", "LookSendMessage.jsp");
		return "board/LookMessage";
	}
	
	@GetMapping("/lookSendMessageList.do")
	@Override
	public ResponseEntity<Object> ajax_SendList(HttpServletRequest request) throws Exception{
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap<Object, Object>> hmList = new ArrayList<HashMap<Object,Object>>();
		
		HttpSession session = request.getSession();
		String send_id = (String) session.getAttribute("memberforBoard");
		
		List<Message_Box_VO> sendList = message_Service.lookSendMessage(send_id);
		
		if(sendList.size()>0) {
			for(int i=0;i<sendList.size();i++) {
				HashMap<Object, Object> hm = new HashMap<Object, Object>();
				hm.put("id", sendList.get(i).getId());
				hm.put("title", sendList.get(i).getTitle());
				hm.put("sendday", sendList.get(i).getSendday());
				hm.put("readyn", sendList.get(i).getReadyn());
				hm.put("messagenum", sendList.get(i).getMessagenum());
				
				hmList.add(hm);
			}
		}
		
		JSONArray json = new JSONArray(hmList);
		return new ResponseEntity<Object>(json.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	@GetMapping("delSendMessages.do")
	@Override
	public ResponseEntity<String> delSendMessages(@RequestParam(value = "valueArrTest[]") List<String> valueArr,HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String send_id = (String) session.getAttribute("memberforBoard");
		
		ResponseEntity<String> resEnt = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			for(int i =0; i<valueArr.size();i++) {
				int messageNum=Integer.valueOf(valueArr.get(i));
				message_Service.delSendMessage(send_id, messageNum);
			}
			resEnt =  new ResponseEntity<String>("success",HttpStatus.CREATED);
			
		} catch (Exception e) {
			resEnt =  new ResponseEntity<String>("error",HttpStatus.CREATED);
			
		}
		
		return resEnt;
		
	}
	
	@GetMapping("/detailMessage.do")
	public String detailMessage(@RequestParam("messagenum") int messagenum,HttpServletRequest request,Model model) throws Exception{
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberforBoard");
		
		Message_Box_VO detailList = message_Service.detailMessage(id, messagenum);
		model.addAttribute("detailList", detailList);
		model.addAttribute("whatPage", "DetailMessage.jsp");
		
		return "board/LookMessage";
	}
	
	@PostMapping("/delDetailMessage.do")
	public String delDetailMessage(@RequestParam("messagenum") int messagenum,HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberforBoard");
		message_Service.delMessage(id, messagenum);
		
		return "redirect: /unicon/message/lookMessage.do";
	}
	
	@GetMapping("/detailSendMessage.do")
	public String detailSendMessage(@RequestParam("messagenum") int messagenum,HttpServletRequest request,Model model) throws Exception{
		HttpSession session = request.getSession();
		String send_id = (String) session.getAttribute("memberforBoard");
		
		Message_Box_VO detailList = message_Service.detailSendMessage(send_id, messagenum);
		model.addAttribute("detailList", detailList);
		model.addAttribute("whatPage", "DetailSendMessage.jsp");
		
		return "board/LookMessage";
	}
	
	@PostMapping("/delSendDetailMessage.do")
	public String delSendDetailMessage(@RequestParam("messagenum") int messagenum,HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String send_id = (String) session.getAttribute("memberforBoard");
		message_Service.delSendMessage(send_id, messagenum);
		
		return "redirect: /unicon/message/lookSendMessage.do";
	}
	
	@PostMapping("replyMessage.do")
	public String replyMessageForm(@RequestParam("messagenum") int messagenum,HttpServletRequest request,Model model) throws Exception{
		HttpSession session = request.getSession();
		String send_id = (String) session.getAttribute("memberforBoard");
		//message_Service.delSendMessage(send_id, messagenum);
		String id = message_Service.replyMessage(send_id, messagenum);
		
		model.addAttribute("id", id);
		model.addAttribute("whatPage", "MessageForm.jsp");
		
		return "board/LookMessage";
	}
}
