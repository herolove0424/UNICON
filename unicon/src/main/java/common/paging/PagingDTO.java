package common.paging;

import org.springframework.web.util.UriComponentsBuilder;

public class PagingDTO {
	
	private int currentPageNo; //현재 페이지 번호
	private int recordsPerPage=10; //페이지당 출력할 데이터 개수
	
	private String searchKeyword;
	private String searchType;
	private String platform;			//콘솔 전용 플랫폼
	
	private String id;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public PagingDTO() {
		this.currentPageNo = 1;
		this.recordsPerPage = 10;
	}
	
	public PagingDTO(int currentPageNo, int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
		//이전등의 기능을 이용해 페이지가 1보다 작아질때 방지
		if(currentPageNo<=0) {
			this.currentPageNo=1;
			return;
		}
		this.currentPageNo=currentPageNo;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		if(currentPageNo<=0) {
			this.currentPageNo=1;
			return;
		}
		this.currentPageNo = currentPageNo;
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}
	
	//making uri 방법 1: 권장(get방식일떄)
	/*public String addPagingParamsToURI(int pageNo) {
		UriComponentsBuilder uriBuilder =  UriComponentsBuilder.fromPath("")
				.queryParam("currentPageNo", this.currentPageNo)
				.queryParam("recordsPerPage", this.recordsPerPage)
				.queryParam("searchKeyword1", this.searchKeyword1)
				.queryParam("searchKeyword2", this.searchKeyword2)
				.queryParam("searchType", this.searchType);
		System.out.println("uriBuilder.toUriString(): "+uriBuilder.toUriString());
		return uriBuilder.toUriString();
	}
	public String addPagingParamsToURI(int pageNo) {
		UriComponentsBuilder uriBuilder =  UriComponentsBuilder.fromPath("")
				.queryParam("currentPageNo", this.currentPageNo)
				.queryParam("recordsPerPage", this.recordsPerPage)
				.queryParam("recordsPerPage", this.searchKeyword)
				.queryParam("recordsPerPage", this.searchType);
		System.out.println("uriBuilder.toUriString(): "+uriBuilder.toUriString());
		return uriBuilder.toUriString();
	}*/
	
	public String addPagingParamsToURI(int pageNo) {
		UriComponentsBuilder uriBuilder =  UriComponentsBuilder.fromPath("")
				.queryParam("currentPageNo", this.currentPageNo)
				.queryParam("recordsPerPage", this.recordsPerPage)
				.queryParam("searchKeyword", this.searchKeyword)
				.queryParam("searchType", this.searchType)
				.queryParam("platform", this.platform);
		System.out.println("uriBuilder.toUriString(): "+uriBuilder.toUriString());
		return uriBuilder.toUriString();
	}

	public String getPlatform() {
		return platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	
	
}
