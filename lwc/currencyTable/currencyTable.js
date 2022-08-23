import { LightningElement } from 'lwc';
    const columns = [
        { label: 'Currency Name', fieldName: 'name', sortable: true },
        { label: 'Exchange Rate', fieldName: 'exchange'},
    ]
export default class CurrencyTable extends LightningElement {
    data = []
    columns = columns
    sortDirection = "asc"
    
    async connectedCallback(){
       try{
            this.data = await setTable()
        }catch(error){
            this.errors = error
        }
        
        async function setTable() {
            try{
                const result = await getRates()
                const kurwa = Object.keys(result).map((item, index) => {
                    return {
                        name: item,
                        exchange: result[item]
                    }
                })
                return kurwa   
            }catch(error){
                return error
            }
            
            }
        
        async function getRates() {
            const currencies = [
              "UAH",
              "PLN",
              "USD",
              "JPY",
              "GBP",
              "CHF",
              "RUB",
              "TRY",
              "CZK",
            ];
            const requestOptions = {
              method: "GET",
              redirect: "follow",
              headers: {
                apikey: "iZ45bTDKzI3RNYmlr9LL5uVrQjfQOxFS",
              },
            };
            try{
                const response = await fetch(
                    `https://api.apilayer.com/exchangerates_data/latest?symbols=${currencies.join(
                    ","
                    )}&base=USD`,
                    requestOptions
                );
                const result = await response.json();
                return result.rates;
            }catch(error){
                return error
            }
        }

       
    }
}