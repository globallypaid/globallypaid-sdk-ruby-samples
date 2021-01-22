import $ from 'jquery';
import { GloballyPaidSDK} from '@globallypaid/js-sdk';


$(() => {
  window.GloballyPaidSDK = GloballyPaidSDK;

  const gpg = new GloballyPaidSDK("pk_test_pr9IokgZOcNd0YGLuW3unrvYvLoIkCCk");
  
  const cardExtended = gpg.createForm("card-extended", {
    style: {
      base: {
        width: "560px",
      },
    },
  });
  
  
  cardExtended.mount("gpg-form");
  
  cardExtended.on(
    "TOKEN_CREATION",
    (tokenPayload) => {
      $.ajax({
        type: "POST",
        url: "http://localhost:4000/payments",
        contentType: "application/json",
        dataType: "json",
        processData: false,
        data: JSON.stringify(tokenPayload),
        // JSON.stringify({          
        //   ccexp: tokenPayload.ExpirationDate,
        //   cvv: tokenPayload.Cvv,
        //   amount: "5",
        //   tokenid: tokenPayload.Token,
        // }),
        success: (response) => {
          if (response.responseText === "Approved") {
            console.log('Success', response);
            cardExtended.showSuccess();
          } else {
            cardExtended.showError("Transaction failed");
          }
          console.log(response);
        },
        error: (response) => {
          if (response.responseText === "Approved") {
            console.log('Success', response);
            cardExtended.showSuccess();
          } else {
            cardExtended.showError("Transaction failed");
          }
          console.log(response);
        },
      });
    },
    (error) => {
      console.log(error);
      cardExtended.showError("Card mismatch", error);
    }
  ); 
});