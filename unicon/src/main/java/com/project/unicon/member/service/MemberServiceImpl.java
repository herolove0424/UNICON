package com.project.unicon.member.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Member_Mapper;
import com.project.unicon.vo.Console_Board_VO;
import com.project.unicon.vo.Free_Board_VO;
import com.project.unicon.vo.Jjim_VO;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.Mobile_Board_VO;
import com.project.unicon.vo.Pc_Board_VO;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {

	@Autowired
	private Member_Mapper memberMapper;
	
	@Autowired
	private JavaMailSender mailSender;

	@Override
	public Member_VO login(Member_VO member) throws Exception {
		System.out.println("ser: " + member);
		member = memberMapper.loginById(member);
		if(member!=null) {
			System.out.println(member);
			Member_VO member2 = memberMapper.getinforecomende(member);
			System.out.println("------------------------------------------------------------------------");
			System.out.println(member);
			System.out.println(member2);
			System.out.println("------------------------------------------------------------------------");
			//member.setHashtag(member2.getHashtag());
			member.setHashtag1(member2.getHashtag1());
			member.setHashtag2(member2.getHashtag2());
			member.setHashtag3(member2.getHashtag3());
			member.setPlay_type(memberMapper.getplaytype(member.getId()));
			//member.setGenre(member2.getGenre());
			member.setGenre1(member2.getGenre1());
			member.setGenre2(member2.getGenre2());
			member.setSmall_category(memberMapper.getsmallcategory(member.getId()));
			
		}
		
		System.out.println(member);
		return member;
	}

	@Override
	public void addMember(Member_VO member) throws Exception {
		memberMapper.insertMember(member);
	}

	@Override
	public int overlapped(String id) throws Exception {
		System.out.println("ser id: " + id);
		return memberMapper.selectOverlappedID(id);

	}

	@Override
	public int overlappednick(String nickname) throws Exception {
		System.out.println("ser nickname: " + nickname);
		return memberMapper.selectOverlappedNCIKNAME(nickname);

	}

	@Override
	public int overlappedemail(String email) throws Exception {
		System.out.println("ser email: " + email);
		return memberMapper.selectOverlappedEMAIL(email);

	}

	@Override
	public int overlappedphone(String phone_number) throws Exception {
		System.out.println("ser phone_number: " + phone_number);
		return memberMapper.selectOverlappedPHONE(phone_number);

	}

	@Override
	public String findid(Member_VO member) throws Exception {
		System.out.println("ser member: " + member.getName());
		return memberMapper.findid(member);
	}

	@Override
	public String findpw(Member_VO member) throws Exception {
		return memberMapper.findpw(member);
	}

	@Override
	public void pwfind2(Member_VO Member_VO) throws Exception {
		memberMapper.pwfind2(Member_VO);
	}

	@Override
	public String mypagepw(Member_VO member) throws Exception {
		return memberMapper.mypagepw(member);
	}

	@Override
	public String gethp(String id) throws Exception {
		return memberMapper.gethp(id);
	}

	@Override
	public void modify(Member_VO modmember) throws Exception {
		memberMapper.modify(modmember);
	}
	@Override
	public void pwmodify(Member_VO Member_VO) throws Exception {
		memberMapper.pwmodify(Member_VO);
	}
	
	@Override
	public String getEmail(String id) throws Exception {
		return memberMapper.getEmail(id);
	}
	
	@Override
	public void requestSend(String id, String email, HttpServletRequest request) throws Exception {
		String key = getKey(false, 20);
		memberMapper.makeKey(id, key);
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			
			String mailtext="<div style=\"font-family: 'Apple SD Gothic Neo', 'sans-serif' !important; width: 540px; height: 600px; border-top: 4px solid green; margin: 100px auto; padding: 30px 0; box-sizing: border-box;\">\r\n" + 
					" 	<h1 style=\"margin: 0; padding: 0 5px; font-size: 28px; font-weight: 400;\">\r\n" + 
					"		<span style=\"font-size: 15px; margin: 0 0 10px 3px;\">Unicon</span><br />\r\n" + 
					"		<span style=\"color: green;\">메일인증</span> 안내입니다.\r\n" + 
					"	</h1>\r\n" + 
					"	<p style=\"font-size: 16px; line-height: 26px; margin-top: 50px; padding: 0 5px;\">\r\n" + 
					"		안녕하세요."+ id +" 님 <br>"+
					"		Unicon에 가입해 주셔서 진심으로 감사드립니다.<br />\r\n" + 
					"		아래 <b style=\"color: green;\">'메일 인증'</b> 버튼을 클릭하여 회원가입을 완료해 주세요.<br />\r\n" + 
					"		감사합니다.\r\n" + 
					"	</p>\r\n" + 
					"\r\n" + 
					"	<a style=\"color: #FFF; text-decoration: none; text-align: center;\" href='localhost:8090" + request.getContextPath() + "/member/certification?id=" + id + "&key=" + key + "' target=\"_blank\"><p style=\"display: inline-block; width: 210px; height: 45px; margin: 30px 5px 40px; background: green; line-height: 45px; vertical-align: middle; font-size: 16px;\">메일 인증</p></a>\r\n" + 
					"\r\n" + 
					"	<div style=\"border-top: 1px solid #DDD; padding: 5px;\">\r\n" + 
					"		<p style=\"font-size: 13px; line-height: 21px; color: #555;\">\r\n" + 
					"			만약 버튼이 정상적으로 클릭되지 않는다면, 아래 링크를 복사하여 접속해 주세요.<br />\r\n" + 
					"			http://172.16.2.9:8090" + request.getContextPath() + "/member/certification?id=" + id + "&key=" + key + 
					"		</p>\r\n" + 
					"	</div>\r\n" + 
					"</div>";
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");			
			messageHelper.setTo(email);
			messageHelper.setText(mailtext, true);
			messageHelper.setSubject("Unicon 이메일 인증");
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void changeEmail(String id, String email) {
		
		memberMapper.changeEmail(id, email);
	}
	
	@Override
	public void mailsendkey(String email, String id, HttpServletRequest request) throws Exception {
		String key = getKey(false, 20);
		memberMapper.makeKey(id, key);
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			
			String mailtext="<div style=\"font-family: 'Apple SD Gothic Neo', 'sans-serif' !important; width: 540px; height: 600px; border-top: 4px solid green; margin: 100px auto; padding: 30px 0; box-sizing: border-box;\">\r\n" + 
					" 	<h1 style=\"margin: 0; padding: 0 5px; font-size: 28px; font-weight: 400;\">\r\n" + 
					"		<span style=\"font-size: 15px; margin: 0 0 10px 3px;\">Unicon</span><br />\r\n" + 
					"		<span style=\"color: green;\">메일인증</span> 안내입니다.\r\n" + 
					"	</h1>\r\n" + 
					"	<p style=\"font-size: 16px; line-height: 26px; margin-top: 50px; padding: 0 5px;\">\r\n" + 
					"		안녕하세요."+ id +" 님<br>"+
					"		Unicon에 가입해 주셔서 진심으로 감사드립니다.<br />\r\n" + 
					"		아래 <b style=\"color: green;\">'메일 인증'</b> 버튼을 클릭하여 회원가입을 완료해 주세요.<br />\r\n" + 
					"		감사합니다.\r\n" + 
					"	</p>\r\n" + 
					"\r\n" + 
					"	<a style=\"color: #FFF; text-decoration: none; text-align: center;\" href='localhost:8090" + request.getContextPath() + "/member/certification?id=" + id + "&key=" + key + "' target=\"_blank\"><p style=\"display: inline-block; width: 210px; height: 45px; margin: 30px 5px 40px; background: green; line-height: 45px; vertical-align: middle; font-size: 16px;\">메일 인증</p></a>\r\n" + 
					"\r\n" + 
					"	<div style=\"border-top: 1px solid #DDD; padding: 5px;\">\r\n" + 
					"		<p style=\"font-size: 13px; line-height: 21px; color: #555;\">\r\n" + 
					"			만약 버튼이 정상적으로 클릭되지 않는다면, 아래 링크를 복사하여 접속해 주세요.<br />\r\n" + 
					"			http://172.16.2.9:8090" + request.getContextPath() + "/member/certification?id=" + id + "&key=" + key + 
					"		</p>\r\n" + 
					"	</div>\r\n" + 
					"</div>";
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");			
			messageHelper.setTo(email);
			messageHelper.setText(mailtext, true);
			messageHelper.setSubject("Unicon 이메일 인증");
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int change_Key(String id, String key) throws Exception {
		int result = 0;
		memberMapper.change_Key(id, key);
		return result;
	}
	
	@Override
	public Integer email_check(String id) throws Exception {
		return memberMapper.email_check(id);
	}
	
	@Override
	public void recommendinsert(Member_VO member) throws Exception {
		memberMapper.recommendinsert(member);
	}
	
	@Override
	public void recommendmodify(Member_VO memberVO) throws Exception {
		memberMapper.recommendmodify(memberVO);
	}


	// 이메일 난수 만드는 메서드
	public String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}
		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}

	// 난수를 이용한 키 생성
	private boolean lowerCheck;
	private int size;

	public String getKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}
	//회원삭제
	@Override
	public void removemember(String id) throws Exception{
		memberMapper.removemember(id);
		memberMapper.removemember2(id);
	}
	//여기서부터 댓글관리
	public List<Map> reply(String id) throws Exception{
		
		return memberMapper.reply(id);
		}
	
	public List<Map> freeboardReply(String id) throws Exception {
		
		return memberMapper.freeboardReply(id);
	}
	public List<Map> pcboardReply(String id) throws Exception {
		
		return memberMapper.pcboardReply(id);
	}
	public List<Map> mobileboardReply(String id) throws Exception {
		
		return memberMapper.mobileboardReply(id);
	}
	public List<Map> consoleboardReply(String id) throws Exception {
		
		return memberMapper.consoleboardReply(id);
	}
	//여기까지
	
	//여기서부터게시글
	
public List<Pc_Board_VO> pcboard(String id) throws Exception{
		
		return memberMapper.pcboard(id);
	}

public List<Console_Board_VO> consoleboard(String id) throws Exception{
	
	return memberMapper.consoleboard(id);
}

public List<Mobile_Board_VO> mobileboard(String id) throws Exception{
	
	return memberMapper.mobileboard(id);
}

public List<Free_Board_VO> freeboard(String id) throws Exception{
	
	return memberMapper.freeboard(id);
}
//여기까지

@Override
public int getjjim(Jjim_VO jjimvo)throws Exception{
	return memberMapper.getjjim(jjimvo);
}
@Override
public void insertjjim(Jjim_VO jjimvo)throws Exception{
	memberMapper.insertjjim(jjimvo);
}

@Override
public void deletejjim(Jjim_VO jjimvo)throws Exception{
	memberMapper.deletejjim(jjimvo);
}

public List<Jjim_VO> jjimlist(String id) throws Exception {
	
	return memberMapper.jjimlist(id);
}

@Override
public void setVisitTotalCount() throws Exception{
	memberMapper.setVisitTotalCount();
}

}
