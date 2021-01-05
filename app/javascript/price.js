function price() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const itemPrice = document.getElementById("item-price");
    const taxPrice = document.getElementById("add-tax-price");
    const profitPrice = document.getElementById("profit");
    const taxValue = Math.floor(itemPrice.value / 10)
    taxPrice.innerHTML =  taxValue.toLocaleString();
    const profitValue = itemPrice.value - taxValue;
    profitPrice.innerHTML = profitValue.toLocaleString();
  });
};
window.addEventListener("load",price)