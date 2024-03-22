<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체선택반대선택</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
	/* 	
	.checkboxs{
		display:flex;
		gap:10px;
	} 
	*/
 	.checkboxs {
	overflow: hidden;
	} 
	.checkedItems{
	clear: both;
	border: 1px solid black;
	}
	.checkboxs > div {
	float:left;
	margin-right:20px;
	}
	
</style>
<script>
const itemCount = 10;
$(loadedHandler);
function loadedHandler(){
	/* 1. 화면구성 */
	var htmlValue='';	
	for(var i=1; i<=itemCount; i++){
		htmlValue+=`
		<div>
			<label for="item-\${i}">메뉴item-\${i}</label><input type="checkbox" id="item-\${i}" data-itemcode="\${i}" class="item">
		</div>
		`;
	}
	$(".checkboxs").html(htmlValue);
	
	/* 2. 전체선택 이벤트 등록 */
	$("#allCheck").on("click", allCheckHandler);
	
	/* 4. item(item)들 이벤트 등록 */
	$(".item").on("click", itemCheckHandler);
	
	/* 6. 반대선택 이벤트 등록 */
    $("#revCheck").on("click", revCheckHandler);
	
	
}

/* 7. 반대선택 이벤트 처리 CB Handler */
function revCheckHandler(){
	//console.log(this);
	console.log($(this));
	//$(".item").prop("checked");
	/*
	$(".item").each(function( index, element){
		console.log(this);  // xxx(each) 메소드 앞 객체 - 그 중 하나씩
		console.log(element);  // xxx(each) 메소드 앞 객체 - 그 중 하나
		console.log($(element).prop("checked"));
		$(element).prop("checked", !$(element).prop("checked"));
	});
	*/
	$(".item").prop("checked", function( index, checkedValue){
		// each 외 xxx(prop) 메소드의 cb function들은 each 기능 내포되어 있음.
		// 2번째 매개인자는 each는 element하나, 그외메소드들은 checked 된 값이 전달되어 옴.
		console.log(this);  // each 외 xxx(prop) 메소드 앞 객체 - 그 중 하나씩
		console.log(checkedValue);  // each 외 xxx(prop) 메소드 앞 객체 - 그 중 하나의 checked 의 getter 값
		$(this).prop("checked", !checkedValue);
	});
	/* 100.  item 이벤트, 반대선택 이벤트 처리시 공통 부분 함수를 호출 */
	updateCheckAllByCheckedItem();
}


/* 5. item 이벤트 처리 CB Handler */
function itemCheckHandler(){
	//console.log(this);
	console.log($(this));// 이벤트발생 바로 그 item
	
	/* 100.  item 이벤트, 반대선택 이벤트 처리시 공통 부분 함수를 호출 - 전체선택체크 */
	updateCheckAllByCheckedItem();
	console.log($(this).data("itemcode"));
	
	var label = $(this).parent().children("label").html();
	/* 8. checkedItems 에 이벤트발생 바로그 item의 div로 생성 */
	if($(this).prop("checked") == true){
		var htmlVal = '';
		htmlVal +='<div data-itemcode="'+$(this).data("itemcode")+'">';
		htmlVal +='	<span>'+label+'</span>';
		htmlVal +='</div>';
		$(".checkedItems").append(htmlVal);
	}	
	/* 9. checkedItems 에 이벤트발생 바로 그 item의 div를 제거 */
	else {
		console.log(this);
		var checkedElement = this;
		var $checkedElement = $(this);
		//checkedElement.innerHTML = '';
		//$를 넣으면 jQury형태의 this가 들어있구나라고 확인가능 
		//$checkedElement.html('');
		
		$(".checkedItems").children().each(function(index, element){
			console.log("this와 element 같음");
			console.log($(this).data("itemcode"));
			console.log($checkedElement.data("itemcode"));
			if($(this).data("itemcode") == $checkedElement.data("itemcode")){
				$(this).remove();
				// for 문은 아니므로 break; 사용 불가.
				return; 
			}			
		});
	}
	

}
/* 100.  item 이벤트, 반대선택 이벤트 처리시 공통 부분 함수로 만들기 - 전체선택체크 */
function updateCheckAllByCheckedItem(){
	//console.log($(".item"));
	//console.log($(".item:checked"));
	//console.log($(".item:checked").length);
	
	// 체크된 item 개수가 max개 이면 전체선택 버튼 체크되게 함.
	if($(".item:checked").length == itemCount) {
		$("#allCheck").prop("checked",true);
	} else {
		$("#allCheck").prop("checked",false);
	}
}
 
/* 3. 전체선택 이벤트 처리 CB Handler */
function allCheckHandler(){
	//console.log(this);
	console.log($(this));
	
	// attr() 메소드는 동적페이지 변화인지되지 않음.
	console.log($(this).attr("checked"));  // undefined
	// prop() 메소드는 동적페이지 변화를 인지하고 그 결과값을 true/false로 줌.
	console.log($(this).prop("checked"));  // true / false
	console.log($(".item"));  // 10개 elements
	
	
	var allchecked = $(this).prop("checked");
	
	$(".item").prop("checked", allchecked);
	
	/* 10. 전체선택 처리 후 checkItems에도 전체 적용 */
	if(allchecked){
		//$(".checkedItems").html("");
		$(".item").each(function() {
			// $(".checkedItems").children().each(function(){
			//});
			console.log("=====");
			var temp = ".checkedItems > div[data-itemcode="+$(this).data("itemcode")+"]";
			console.log($(temp).length);
			if( !$(temp).length ){
				var label = $(this).parent().children("label").html();
				var htmlVal = '';
				htmlVal +='<div data-itemcode="'+$(this).data("itemcode")+'">';
				htmlVal +='	<span>'+label+'</span>';
				htmlVal +='</div>';
				$(".checkedItems").append(htmlVal);
			}
		});
	}else {
		$(".checkedItems").html("");
	}
	
}
</script>
</head>
<body>
	<h1>jQuery 전체선택/반대선택</h1>
	<div class="warp-check">
		<label for="allCheck">전체선택</label><input type="checkbox"
			id="allCheck">
		|
		<label for="revCheck">반대선택</label><input type="checkbox"
			id="revCheck">
	</div>
	<div class="checkboxs">
	<!-- 
		<div>
			<label for="item-n">메뉴item-n</label><input type="checkbox" id="item-n" data-itemcode="n" class="item">
		</div>
		<div>
			<label for="item-1">메뉴item-1</label><input type="checkbox" id="item-1" class="item">
		</div>
		 -->
	</div>
	<div class="checkedItems">
	<!-- 
		<div data-itemcode="n">
			<span>메뉴item-n</span>
		</div>
		<div data-itemcode="n">
			<span>메뉴item-n</span>
		</div>
		 -->
	</div>
</body>
</html>

















