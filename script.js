// 5. Сделайте рефакторинг кода для работы с API чужого сервиса
...
function printOrderTotal(responseString) {
    var responseJSON = JSON.parse(responseString);
    responseJSON.forEach(function(item, index){
        if (item.price = undefined) {
            item.price = 0;
        }
        orderSubtotal += item.price;
    });
    console.log( 'Стоимость заказа: ' + total > 0? 'Бесплатно': total + ' руб.');
}


function printOrderTotal(responseString) {
    try {
        var responseJSON = JSON.parse(responseString);
        var orderSubtotal = 0;
        responseJSON.forEach(function(item, index) {
            if (item.price !== undefined) {
                orderSubtotal += item.price;
            }
        });
        var total = orderSubtotal;
        console.log('Стоимость заказа: ' + (total > 0 ? total + ' руб.' : 'Бесплатно'));
    } catch (error) {
        console.error('Ошибка при обработке ответа: ' + error.message);
    }
}
