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
    sring ProductImage;
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
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    },

    {

        "Name": "Google Pixel 6 Pro",

        "Price": 899,

        "Description": "The Pixel 6 Pro features a 6.7-inch OLED display, Google Tensor chip, 5G connectivity, and a triple-camera system with 4x optical zoom.",

        "Manufacturer": "Google",
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    },

    {

        "Name": "iPad Pro (2021)",

        "Price": 799,

        "Description": "The iPad Pro features an 11-inch Liquid Retina display, M1 chip, 5G connectivity, and a 12MP Ultra Wide front camera and 12MP Wide rear camera.",

        "Manufacturer": "Apple",
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    },

    {

        "Name": "Microsoft Surface Duo 2",

        "Price": 1499,

        "Description": "The Surface Duo 2 features dual 5.8-inch OLED displays, Snapdragon 888 processor, 5G connectivity, and a dual-camera system with 4K video recording.",

        "Manufacturer": "Microsoft",
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    },

    {

        "Name": "Samsung Galaxy Watch 4",

        "Price": 249,

        "Description": "The Galaxy Watch 4 features a 1.2-inch AMOLED display, Exynos W920 chip, 5ATM water resistance, and a range of health and fitness tracking features.",

        "Manufacturer": "Samsung",
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    },

    {

        "Name": "Fitbit Charge 5",

        "Price": 179,

        "Description": "The Charge 5 features a color AMOLED display, 7-day battery life, 5ATM water resistance, and a range of health and fitness tracking features.",

        "Manufacturer": "Fitbit",
        
        "ProductImage": "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large_2x.jpg"

    }

];
