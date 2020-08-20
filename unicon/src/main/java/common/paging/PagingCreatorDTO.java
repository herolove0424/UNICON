package common.paging;


public class PagingCreatorDTO {
	
	private PagingDTO pagingDTO;
	private int groupNoOfPage;
	
	private int endPageNo; // 현재 페이지가 속한 페이징 그룹의 끝페이지
	private int startPageNo; //현재 페이지가 속한 페이징 그룹의 시작 페이지
	
	private int pageNoCnt; //화면 하단에 출력할 페이지 번호 개수
	private int realLastPageNo;//현재 페이지 번호
	// 2020.07.27 민우의 작살나는 페이징 코드 변수 추가
	private int realFirstPageNO; // 맨처음으로 돌아가는 페이지 번호.
	private int realMajimakPageNO; //맨 마지막으로 가는 페이지 번호.
	
	private int totalRecordCnt; //전체 레코드 개수(get) > (차후 총 페이지수 /페이지당 표시할 행 개수 ) > ceil처리해서 표시
	
	private boolean isPrev=false; //prev 버튼 표시 유무(true:표시됨/false:표시 안됌)
	private boolean isNext = false; //next 버튼 표시 유무(true:표시됨/false:표시 안됌)
	
	private String platform;
	
	public PagingCreatorDTO(PagingDTO pagingDTO, int totalRecordCnt) {
		System.out.println("============pagingcreator 생성자 생성 시작===========");
		//this.pagingDTO = pagingDTO;
		
		this.pagingDTO = pagingDTO;
		this.totalRecordCnt=totalRecordCnt;
		
		this.pageNoCnt=10;
		
		this.groupNoOfPage=(int)(Math.ceil(pagingDTO.getCurrentPageNo()/(double)this.pageNoCnt));
		
		this.endPageNo = this.groupNoOfPage * this.pageNoCnt;
		this.startPageNo = this.endPageNo - (this.pageNoCnt - 1);
		
		realLastPageNo= (int) (Math.ceil(((double)(totalRecordCnt))/pagingDTO.getRecordsPerPage()));
		
		//맨 처음으로 돌아가는 페이지 변수 2020.07.27 민우 추가
		setRealFirstPageNO(((int) (Math.ceil((double)( pagingDTO.getCurrentPageNo()-pagingDTO.getCurrentPageNo() ) + 1 ))));
				
		//맨 마지막으로 돌아가는 페이지 변수 2020.07.27 민우 추가
		setRealMajimakPageNO(((int)(Math.ceil(((double)(totalRecordCnt))/pagingDTO.getRecordsPerPage()))) + 1);
				
		if(realLastPageNo<endPageNo) {
			this.endPageNo=realLastPageNo;
		}
		
		this.isPrev=this.startPageNo>1;
		this.isNext=this.endPageNo<realLastPageNo;
		
		System.out.println("=======페이징변수 값들=================");
		System.out.println("현재 페이지 번호: "+pagingDTO.getCurrentPageNo());
		System.out.println("페이지 당 표시 레코드 수: "+pagingDTO.getRecordsPerPage());
		System.out.println("하단 표시 숫자 개수: "+this.pageNoCnt);
		System.out.println("페이지의 그룹 번호: "+this.groupNoOfPage);
		System.out.println("시작 페이지 번호: "+startPageNo);
		System.out.println("끝 페이지 번호: "+endPageNo);
		System.out.println("=================================");
		
	}
	
	// 08/11 민우 추가
	public PagingCreatorDTO(PagingDTO pagingDTO, int totalRecordCnt, String platform) {
		
		this.pagingDTO = pagingDTO;
		this.totalRecordCnt = totalRecordCnt;
		this.pageNoCnt = 10;
		this.platform=pagingDTO.getPlatform();
		
		this.groupNoOfPage = (int) (Math.ceil(pagingDTO.getCurrentPageNo()/(double) this.pageNoCnt));
		
		//현재 페이지가 속한 끝페이지(10: 페이징 표시 숫자개수)
		this.endPageNo = this.groupNoOfPage * this.pageNoCnt;
		
		//현재 페이지가 속한 시작페이지(9: 페이징 숫자 표시 개수-1)
		this.startPageNo = this.endPageNo - (this.pageNoCnt - 1);
		
		//실제 마지막 페이지 번호
		realLastPageNo = (int) (Math.ceil(((double)(totalRecordCnt))/pagingDTO.getRecordsPerPage()));
		
		//맨 처음으로 돌아가는 페이지 변수
		realFirstPageNO = ((int) (Math.ceil((double)( pagingDTO.getCurrentPageNo()-pagingDTO.getCurrentPageNo() ) + 1 )));
		
		//맨 마지막으로 돌아가는 페이지 변수
		realMajimakPageNO = ((int)(Math.ceil(((double)(totalRecordCnt))/pagingDTO.getRecordsPerPage()))) + 1;
		
		//실제 마지막 페이지 < 계산된 마지막 페이지(마지막그룹의 마지막 페이지 번호)
		//마지막 페이징 그룹의 경우에만 해당됨
		if(realLastPageNo < endPageNo) {
			this.endPageNo = realLastPageNo;
		}
		
		//참 : 이전 표시 링크 표시
		this.isPrev = this.startPageNo > 1;
		//참 : 다음 표시 링크 표시
		this.isNext = this.endPageNo < realLastPageNo;
		
		System.out.println("=======페이징변수 값들=================");
		System.out.println("현재 페이지 번호: "+pagingDTO.getCurrentPageNo());
		System.out.println("페이지 당 표시 레코드 수: "+pagingDTO.getRecordsPerPage());
		System.out.println("하단 표시 숫자 개수: "+this.pageNoCnt);
		System.out.println("페이지의 그룹 번호: "+this.groupNoOfPage);
		System.out.println("시작 페이지 번호: "+startPageNo);
		System.out.println("끝 페이지 번호: "+endPageNo);
		System.out.println("=================================");
	}


	public int getRealLastPageNo() {
		return realLastPageNo;
	}


	public void setRealLastPageNo(int realLastPageNo) {
		this.realLastPageNo = realLastPageNo;
	}


	public PagingDTO getPagingDTO() {
		return pagingDTO;
	}


	public void setPagingDTO(PagingDTO pagingDTO) {
		this.pagingDTO = pagingDTO;
	}


	public int getGroupNoOfPage() {
		return groupNoOfPage;
	}


	public void setGroupNoOfPage(int groupNoOfPage) {
		this.groupNoOfPage = groupNoOfPage;
	}


	public int getEndPageNo() {
		return endPageNo;
	}


	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}


	public int getStartPageNo() {
		return startPageNo;
	}


	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}


	public int getPageNoCnt() {
		return pageNoCnt;
	}


	public void setPageNoCnt(int pageNoCnt) {
		this.pageNoCnt = pageNoCnt;
	}


	public int getTotalRecordCnt() {
		return totalRecordCnt;
	}


	public void setTotalRecordCnt(int totalRecordCnt) {
		this.totalRecordCnt = totalRecordCnt;
	}


	public boolean getIsPrev() {
		return isPrev;
	}


	public void setIsPrev(boolean isPrev) {
		this.isPrev = isPrev;
	}


	public boolean getIsNext() {
		return isNext;
	}


	public void setIsNext(boolean isNext) {
		this.isNext = isNext;
	}


	public int getRealFirstPageNO() {
		return realFirstPageNO;
	}


	public void setRealFirstPageNO(int realFirstPageNO) {
		this.realFirstPageNO = realFirstPageNO;
	}


	public int getRealMajimakPageNO() {
		return realMajimakPageNO;
	}


	public void setRealMajimakPageNO(int realMajimakPageNO) {
		this.realMajimakPageNO = realMajimakPageNO;
	}
	


	//get방식에서만 쓸수있는 메소드 
	
	
	
}
