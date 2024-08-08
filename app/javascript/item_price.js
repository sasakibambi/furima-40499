window.addEventListener('turbo:load', () => {
   // 金額を入力する場所のidを取得し、変数に格納する
  const priceInput = document.getElementById("item-price");

  // 販売手数料を表示する場所のidを取得し、変数に格納する
  const commissionDisplay = document.getElementById("add-tax-price");

  // 販売利益を表示する場所のidを取得し、変数に格納する
  const profitDisplay = document.getElementById("profit");

  // （学習用）コンソールに取得した要素を表示する↓
  // console.log(priceInput);
  // console.log(commissionDisplay);
  // console.log(profitDisplay);

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
  
  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = Math.floor(inputValue * 0.1);

  const profitDom = document.getElementById("profit");
  profitDom.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML);
  })
});

