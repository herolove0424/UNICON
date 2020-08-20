package com.project.unicon.board.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.unicon.vo.Message_Box_VO;

public interface Massage_Controller {
	public String sendMassageForm(@RequestParam("id") String id,Model model) throws Exception;
	public ResponseEntity<String> messageSend(@ModelAttribute("message") Message_Box_VO message,HttpServletRequest request) throws Exception;
	public String lookMessage (HttpServletRequest request,Model model) throws Exception;
	public ResponseEntity<String> delMessage(@RequestParam(value = "valueArrTest[]") List<String> valueArr,HttpServletRequest request) throws Exception;
	public String lookSendMessage(HttpServletRequest request,Model model) throws Exception;
	public ResponseEntity<Object> ajax_SendList(HttpServletRequest request) throws Exception;
	public ResponseEntity<String> delSendMessages(@RequestParam(value = "valueArrTest[]") List<String> valueArr,HttpServletRequest request) throws Exception;
	
}
