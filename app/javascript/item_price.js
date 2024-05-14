window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    addTaxPrice.innerHTML = Math.floor(inputValue * 0.1);
    profit.innerHTML = inputValue - Math.floor(inputValue * 0.1);
  })
});