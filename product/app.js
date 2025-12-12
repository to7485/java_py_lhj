import { apiFetch } from "./api.js";

//DOM 요소를 참조(등록)
const itemTableBody = document.querySelector("#itemTableBody");
const addItemForm = document.querySelector("#addItemForm");
const messageElement = document.querySelector("#message");

//주문 관련 DOM
const orderButton = document.querySelector("#orderButton");
const orderMessageElement = document.querySelector("#orderMessage");

//주문내역 관련 DOM 요소를 추가
//주문내역 버튼
const fetchOrdersButton = document.querySelector("#fetchOrdersButton");
//테이블의 tbody
const orderHistoryTableBody = document.querySelector("#orderHistoryTableBody")
//메시지
const orderHistoryMessageElement = document.querySelector("#orderHistoryMessageElement")

//-----------------------------------
//초기화 함수
//-----------------------------------
//화면에 dom요소들이 로딩이 완료됐다면, 콜백을 함수를 실행해라.
document.addEventListener("DOMContentLoaded", () => {
    //목록 조회
    fetchProducts();

    //상품 추가
    addItemForm.addEventListener("submit", handleAddItem);

    //주문내역 조회
    fetchOrdersButton.addEventListener("click", handleFetchOrders);
})

//-----------------------------------
//상품 목록을 조회하는 fetchProducts함수
//-----------------------------------
async function fetchProducts(){
    //tbody의 <td>에 상품 목록을 로딩중...
    itemTableBody.innerHTML = '<tr><td colspan="8">상품 목록 로딩 중...</td></tr>';
    try {
        //apiFetch() 함수를 이용하여 서버에 요청하고 데이터를 반환받는다.
        const products = await apiFetch('/product');
        //잘 넘어왔는지 콘솔에 띄운다.
        //console.log(products);
        renderTable(products);


        //Cross-Origin 처리
    } catch (error) {
        //apiFetch에서 발생한 에러를 여기서 처리
        //tbody에 "상품 목록을 불러올 수 없습니다."
        itemTableBody.innerHTML = '<tr><td colspan="8">상품 목록을 불러 올 수 없습니다.</td></tr>';
    }
}

//-----------------------------------
//테이블을 렌더링 해주는 함수
//-----------------------------------
function renderTable(products){
    itemTableBody.innerHTML = '';
    if(products.length === 0){
        itemTableBody.innerHTML = '<tr><td colspan="8">등록된 상품이 없습니다.</td></tr>';
        return;
    }
    products.forEach(product => {
        addNewRowToTable(product);
    });

    //라디오 버튼 이벤트 리스너 등록
    document.querySelectorAll('input[name=selectedProduct]').forEach( radio => {
        radio.addEventListener('change', handleRadioChange);
    })
}

//-----------------------------------
//행을 만들고 각각의 칸에 데이터를 넣어주는 함수
//-----------------------------------
function addNewRowToTable(item){
    //상품 등록 시 초신 상품이 테이블의 가장 위에오도록 작성하기
    //<tbody>에 해당하는 itemTableBody 내부에 새로운 행(Row) 즉 <tr>요소를 생성하고 삽입하는 역할
    const row = itemTableBody.insertRow(0);
    //테이블 행<tr>에 <td>를 생성하고, 텍스트를 넣는 작업

    // 1. 단일 선택 라디오 버튼
    const radioCell = row.insertCell(0);
    const radio = document.createElement('input');
    radio.type = 'radio';
    radio.name = 'selectedProduct'; // 모든 라디오 버튼이 같은 그룹에 속하게 함
    radio.value = item.productId; // 상품 ID를 값으로 설정
    radioCell.appendChild(radio);

    // 2. 주문 개수 입력 필드
    const orderCountCell = row.insertCell(1);
    const orderInput = document.createElement('input');
    orderInput.type = 'number';
    orderInput.min = '1';
    orderInput.id = `orderCount-${item.productId}`; // 상품 ID로 고유 ID 부여
    orderInput.classList.add('order-count-input');
    orderInput.placeholder = '개수';
    orderInput.disabled = true; // 기본 비활성화
    orderInput.style.width = '60px';
    orderCountCell.appendChild(orderInput);
    
    // 3. 상품 정보 (총 8개의 셀을 맞추기 위해 인덱스 조정)
    row.insertCell(2).textContent = item.productId;
    row.insertCell(3).textContent = item.productName;
    row.insertCell(4).textContent = item.productStock;
    row.insertCell(5).textContent = item.productPrice;
    row.insertCell(6).textContent = item.registerDate;
    row.insertCell(7).textContent = item.updateDate;
}

//-----------------------------------
//상품 추가하는 함수
//-----------------------------------
async function handleAddItem(event){
    event.preventDefault()//특정 이벤트에 의해 발생할 예정이었던 브라우저의 기본 동작을 중단시키는 역할 페이지의 새로고침을 막으려고 사용

    //input에 적힌 내용들을 가지고 서버로 전달하기 위한 newProduct 객체
    const newProduct = {
        productName: document.querySelector("#productName").value,
        productStock: document.querySelector("#productStock").value,
        productPrice: document.querySelector("#productPrice").value
    }
    //message에 "등록중..."; 이라고 띄우기
    //message의 글씨 색을 #007bff로 바꾸기
    messageElement.textContent = "등록 중...";
    messageElement.style.color = '#007bff';

    //try-catch에서 method,headers,body 옵션을 명시하여 apiFetch메서드를 호출
    try {
        await apiFetch('/product',{
            method : 'POST',
            headers : {"Content-Type":"application/json"},
            body : JSON.stringify(newProduct)
        });

        //상품등록 후, 전체 목록을 다시 조회하여 테이블을 갱신한다.
        await fetchProducts();

        addItemForm.reset();
        messageElement.textContent = `상품 "${newProduct.productName}"이(가) 등록되었습니다.`
        messageElement.style.color = '#28a745';

    } catch (error) {
        messageElement.textContent = `오류 : ${error.message}`;
        messageElement.style.color = 'red';
    }
}

//-----------------------------------
//주문 내역을 조회하는 함수
//-----------------------------------
async function handleFetchOrders(event){
    event.preventDefault();
    //메시지의 내용을 "주문 내역 로딩 중...";
    //메시지의 글씨색 #007bff;


        //GET 조회 요청을 하여 주문 내역 데이터 받기
        const orders = await apiFetch("/orders/total");
        
        //데이터를 받아서 테이블에 넣어주는 역할
        renderOrderHistoryTable(orders);

        orderHistoryMessageElement.textContent = `총 ${orders.length}건의 주문 내역이 조회되었습니다.`;
        orderHistoryMessageElement.style.color = '#28a745';
}

function renderOrderHistoryTable(orders){
    //orders에 내용이 없다면 tbody에 "등록된 주문 내역이 없습니다."
    if(orders.length === 0){
        orderHistoryTableBody.innerHTML = '<tr><td colspan="5">등록된 주문 내역이 없습니다.</td></tr>'
        return;
    }
    //최신 주문 내역이 위에 오도록 데이터를 추가 (renderTable 함수 참고)
    orders.forEach(order => {
        const row = orderHistoryTableBody.insertRow(0);
        //상품이름
        row.insertCell(0).textContent = order.productName;
        row.insertCell(1).textContent = order.productPrice;
        row.insertCell(2).textContent = order.productCount;
        row.insertCell(3).textContent = order.totalPrice;
        row.insertCell(4).textContent = order.orderDate;
    })
}

//라디오버튼 변경 처리 함수
function handleRadioChange(event){
    //모든 주문 개수 입력 필드를 비활성화
    document.querySelectorAll('.order-count-input').forEach( input => {
        input.disabled = true;
        input.value='';
    });

    //선택된 라디오 버튼의 상품 ID를 가져온다.
    const selectedProductId = event.target.value;

    //선택된 상품 ID에 해당하는 입력 필드를 찾아서 활성화
    const selectedInput = document.querySelector(`#orderCount-${selectedProductId}`);
    if(selectedInput){
        selectedInput.disabled = false;
        //입력 필드를 포커스하여 사용자 입력 대기
        selectedInput.focus();
    }
}

//주문하기
async function handleOrder(){
    //체크된 라디오버튼을 찾는다.
    const selectedRadio = document.querySelector('input[name="selectedProduct"]:checked');

    if(!selectedRadio){
        orderMessageElement.textContent = '주문할 상품을 선택해주세요';
        orderMessageElement.style.color = 'orange';
        return;
    }

    //서버로 넘기기위한 데이터를 가져온다.
    const productId = selectedRadio.value;
    const orderInput = document.querySelector(`#orderCount-${productId}`);
    const productCount = parseInt(orderInput,10); //입력한 개수를 숫자로 변환

    //진짜 숫자를 입력했는지, 음수를 입력했는지 조사
    if(isNaN(productCount) || productCount < 0){
        orderMessageElement.textContent = '유효한 주문 개수를 입력해주세요(1이상)';
        orderMessageElement.style.color = 'orange';
        orderInput.focus();
        return;
    }

    //서버에 보낼 주문데이터
    const orderData = {
        productId : productId,
        productCount : productCount
    }

    orderMessageElement.textContent = '주문 처리중...';
    orderMessageElement.style.color = '#007bff';

    try{
        //서버에 요청
        const updatedProducts = await apiFetch()
    }


}