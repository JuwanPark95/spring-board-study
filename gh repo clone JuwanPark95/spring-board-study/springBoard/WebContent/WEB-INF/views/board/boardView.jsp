<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<body>
<form action="/board/boardUpdate.do" method="post" id="frm" style="display: none;">
	<input name="boardNum" type="text" size="50" value="${board.boardNum}" style="display: none;" > 
	<input name="boardType" type="text" size="50" value="${board.boardType}" style="display: none;"> 
</form>

<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a id="boardUpdateBtn" type="submit" href="#">수정</a>
			<a id="boardDeleteBtn" href="#">삭제</a>
			<a href="/board/boardList.do" style="margin-left: 20px;">List</a>
		</td>
	</tr>
	
</table>	



<script type="text/javascript">

	$j("#boardUpdateBtn").on("click",function(){
		$j('#frm').submit();
	});
	
</script>

<script type="text/javascript">

	$j(document).ready(function(){
	
		$j('#boardDeleteBtn').on('click',function(){
			var $frm = $j('#frm :input');
			var param = $frm.serialize();
			
			$j.ajax({
				url: "/board/boardDelete.do",
				dataType: "json",
				type: "POST",
				data: param,
				success: function(data, textStatus, jqXHR)
				{
					alert("삭제완료!");
					
					location.href = "/board/boardList.do?pageNo=1";
				},
				error: function(jqXHR, textStatus, errorThrown)
				{
					alert("삭제실패!");
				}
			});
		});
	});
	
</script>
</body>
</html>