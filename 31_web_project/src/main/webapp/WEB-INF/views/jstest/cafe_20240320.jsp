<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페계산기</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>

//window.onload = loadedHandler;
//$(function형태의값을넣으면 window.onload되면 실행할 CallBack함수임);
$(loadedHandler);  


function loadedHandler(){
	console.log("loaded 이벤트 발생시 호출됨. 주로 event 등록하는 행동을 함");
	// event 등록
    $("[type=button]").on("click", calcClickHandler);
    $('.c').on("blur", cntBlurHandler);
    $('.c').hover(function(){
    	$(this).addClass("on");
    }, function(){
    	$(this).removeClass("on");
    });
    

    
	// 확인용 test var elem = $("td"); console.log(elem);
}
function cntBlurHandler(e){
    // 메뉴마다 합계가격
    $(this).parent().next().children('input.p').val(
        $(this).parent().prev().text() * $(this).val()  );
    updateTotal();
}
function calcClickHandler(e){
    $(".c.in").each(function(idx, item){
        //this = item
        console.log(item);
        // 메뉴마다 합계가격
        $(this).parent().next().children('input.p').val(
            $(this).parent().prev().text() * $(this).val()  );
    });
    updateTotal();
}
function updateTotal(){
    var sum = 0;
    // 메뉴 총 개수 합계 
    $(".c.in").each(function (idx, item){
        // each - for문은 대신함. event에 handler 를 등록함
        // each function 에서의 this사용시 위 this와 헛갈림. 
        //console.log(price);
        // item = this 
        console.log(item);
        //if(idx != ($(".c").length-1)){
            var i = Number($(item).val());
            if (isNaN(i)){
                i = 0;
            }
            sum += i;
        //}
    });
    console.log(sum);
    $("#cTotalCnt").val(sum);

    sum = 0;
    // 합계 
    $(".p").each(function (idx, item){
        console.log(item);
        if(idx != ($(".p").length-1)){
            // Number() 대신 * 1 로 숫자형태변경
            var i = $(item).val() * 1;
            if (isNaN(i)){
                i = 0;
            }
            sum += i;
        }
    });
    console.log(sum);
    $("#cTotalPrice").val(sum);
}
</script>
</head>
<body>

<script>
//document.getElemnetById("").onclick = function(){};
	console.log("그냥여기");
	var elem = $("td");
	console.log(elem);
</script>


<form >
	<table border="1">
		<tr>
			<th>메뉴</th>
			<th>가격</th>
			<th>수량</th>
			<th>합계</th>
		</tr>
		<tr>
			<td>아메리카노</td>
			<td><input type="text" value="2500" disabled="disabled"></td>

			<td><input type="text" name="c1" class="c in"></td>
			<td><input type="text" name="c1Price" class="p" readonly></td>
		</tr>
		<tr>
			<td>라떼</td>
			<td>3000</td>
			<td><input type="text" name="c2" class="c in"></td>
			<td><input type="text" name="c2Price" class="p" readonly></td>
		</tr>
		<tr>
			<td>생강라떼</td>
			<td>4500</td>
			<td><input type="text" name="c3" class="c in"></td>
			<td><input type="text" name="c3Price" class="p" readonly></td>
		</tr>
		<tr>
			<td>딸기바나나라떼</td>
			<td>4500</td>
			<td><input type="text" name="c4" class="c in"></td>
			<td><input type="text" name="c4Price" class="p" readonly></td>
		</tr>
		<tr>
			<th>합계</th>
			<th></th>
			<th><input type="text" name="cTotalCnt" id="cTotalCnt" class="c"
				readonly></th>
			<th><input type="text" name="cTotalPrice" id="cTotalPrice"
				class="p" readonly></th>
		</tr>
		<tr>
			<td colspan="4"><input type="button" value="계산하기"> <input
				type="reset"></td>
		</tr>
	</table>
</form>


<script>
console.log("여긴 body 꼬다리");
	var elem = $(".in");
	console.log(elem);
</script>
</body>
</html>