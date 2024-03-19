<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section>
    <article>
    	<h1>회원가입</h1>
        <form method="get" action="#">
            <div>
                <input type="color" name="color">
            </div>  
            <div>
                <input type="date" name="date">
            </div>   
            <div>
                <select name="select">
                    <optgroup label="과일">
                        <option value="f01">banana</option>
                        <option value="f02" selected>신선한딸기</option>
                        <option value="f03">waltnet</option>
                    </optgroup>
                    <optgroup label="구황작물">
                        <option value="f01">banana</option>
                        <option value="f02">신선한딸기</option>
                        <option value="f03">waltnet</option>
                    </optgroup>
                    
                </select>
            </div>
            <div>
                <input type="search" list="datalist" name="n3">
            </div>
            <div>
                <!-- <input type="submit" value="전달"> -->
                <button class="btn btn-success">기본type이submit</button>
                <button type="button">버튼1</button>
            </div>
            <div>
                id:<input type="text" name="id" required autofocus>
                pwd:<input type="password" name="pwd" required>
                readonly:<input type="text" name="readonly" value="readonly는value필수" readonly>
            </div> 
        </form>
    </article>
</section>
    