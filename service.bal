import ballerina/http;
import ballerina/io;

// Define the data type for Item
type Item record {
    int id;
    string name;
    decimal price;
};

// Define some sample items
Item[] items = [
    {id: 1, name: "Apple", price: 0.99},
    {id: 2, name: "Banana", price: 1.50},
    {id: 3, name: "Orange", price: 1.25}
];

// Define the endpoint for listing items
endpoint http:Listener listener {
    port: 8080
};

// Define the resource for listing all items
@http:ResourceConfig {
    methods: ["GET"],
    path: "/items"
}
function listItems(http:Caller caller, http:Request request) {
    // Return the HTTP response with the list of items
    http:Response response = new;
    response.statusCode = 200;
    response.setHeader("Content-Type", "application/json");
    response.setJsonPayload(items);
    _ = caller->respond(response);
}
