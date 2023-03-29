import ballerina/http;
import ballerina/lang.array as 'array;

service / on new http:Listener(9090) {

    resource function get orders() returns Order[]|error {
        Order[] orders = [];
        foreach json item in ordersList {
            orders.push(check item.cloneWithType(Order));
        }
        return orders;
    }
    
    resource function put orders/[string name](@http:Payload Order newOrder) returns json[]|error {
        json newOrderJson = newOrder;
        ordersList.push(newOrderJson);
        return ordersList;
    }

    resource function delete orders/[string name]() returns Order|error? {
        foreach json item in ordersList {
            if (item.Name == name) {
                json removed = ordersList.remove(<int>'array:indexOf(ordersList, item));
                return removed.cloneWithType(Order);
            }
            
        }   
    }

    resource function get orders/[string name]() returns Order|error? {
        foreach json item in ordersList {
            if (item.Name == name) {
                json orderDetail = ordersList[<int>'array:indexOf(ordersList, item)];
                return orderDetail.cloneWithType(Order);
            }  
        }   
    }
}

public type Order record {|
    string Name;
    int Price;
    string Description;
    string Manufacturer;
    string ProductImage;
|};

public json[] ordersList = [

    {

        "Name": "Apple iPhone 13",

        "Price": 799,

        "Description": "The iPhone 13 features a 6.1-inch Super Retina XDR display, A15 Bionic chip, 5G connectivity, and a dual-camera system with night mode.",

        "Manufacturer": "Apple",
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    },

    {

        "Name": "Samsung Galaxy S21 Ultra",

        "Price": 1199,

        "Description": "The Galaxy S21 Ultra features a 6.8-inch Dynamic AMOLED 2X display, Snapdragon 888 processor, 5G connectivity, and a quad-camera system with 100x Space Zoom.",

        "Manufacturer": "Samsung",
        
        "ProductImage": "https://m.media-amazon.com/images/I/81ZOucfnADL._AC_SL1500_.jpg"

    },

    {

        "Name": "Google Pixel 6 Pro",

        "Price": 899,

        "Description": "The Pixel 6 Pro features a 6.7-inch OLED display, Google Tensor chip, 5G connectivity, and a triple-camera system with 4x optical zoom.",

        "Manufacturer": "Google",
        
        "ProductImage": "https://www.att.com/idpassets/global/devices/phones/google/google-pixel-6-pro/Gallery/Cloudy-White/6074D-6.jpg"

    },

    {

        "Name": "iPad Pro (2021)",

        "Price": 799,

        "Description": "The iPad Pro features an 11-inch Liquid Retina display, M1 chip, 5G connectivity, and a 12MP Ultra Wide front camera and 12MP Wide rear camera.",

        "Manufacturer": "Apple",
        
        "ProductImage": "https://celltronics.lk/wp-content/uploads/2021/08/Apple-iPad-Pro-2021-M1-11-inch-WiFi-Cellular-128GB-silver.jpg"

    },

    {

        "Name": "Microsoft Surface Duo 2",

        "Price": 1499,

        "Description": "The Surface Duo 2 features dual 5.8-inch OLED displays, Snapdragon 888 processor, 5G connectivity, and a dual-camera system with 4K video recording.",

        "Manufacturer": "Microsoft",
        
        "ProductImage": "https://www.notebookcheck.net/fileadmin/Notebooks/Microsoft/Surface_Duo_2/4_to_3_Teaser_Microsoft_Surface_Duo2.jpg"

    },

    {

        "Name": "Samsung Galaxy Watch 4",

        "Price": 249,

        "Description": "The Galaxy Watch 4 features a 1.2-inch AMOLED display, Exynos W920 chip, 5ATM water resistance, and a range of health and fitness tracking features.",

        "Manufacturer": "Samsung",
        
        "ProductImage": "data:image/jpeg;base64,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"

    },

    {

        "Name": "Fitbit Charge 5",

        "Price": 179,

        "Description": "The Charge 5 features a color AMOLED display, 7-day battery life, 5ATM water resistance, and a range of health and fitness tracking features.",

        "Manufacturer": "Fitbit",
        
        "ProductImage": "https://lifemobile.lk/wp-content/uploads/2021/11/Fitbit-Charge-5.jpg"

    }

];
