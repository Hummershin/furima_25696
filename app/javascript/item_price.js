window.addEventListener("load", function(){

  const price_field = document.getElementById("item-price")
  price_field.addEventListener("keyup", function(){
    let price = this.value;
    let fee = Math.floor(price * 0.1) //販売手数料
    let profit = Math.floor(price - fee) //売買利益

    const fee_field = document.getElementById("add-tax-price") //販売手数料が表示される部分
    const profit_field = document.getElementById("profit") //売買利益が表示される部分
    fee_field.textContent = fee;
    profit_field.textContent = profit;
  })
})