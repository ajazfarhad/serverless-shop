# serverless-shop

Example e-commerce shop API. Built using AWS tools and Serverless framework


### High level diagram of the architecture:
![architecture][architecture]


### **Setup & Deployment**
run the following command to deploy the stack

`sls deploy --aws-profile profile-name`
or
`sls deploy`

without profile name it will use the default profile

**for removing the entire stack run the following command**

`sls remove --aws-profile profile-name`
or
`sls remove`

### **Methods**

| Verb  | Path  | Action  |
|-------|-------|---------|
| GET      |    /products/pk/:pk/sk/:sk   |    Show     |
| POST      |  /products     |    Create     |
|   DELETE    | products/pk/:pk/sk/:sk       |    Delete     |
|   PATCH    | products/pk/:pk/sk/:sk       |    Update     |

**Show Product**
----
  Returns single product resource.
* **Response:**
  * **Code:** 200
    **body:**
    ![response][response]

* **API Key Required:**
`false`

**Create Product**
----
  create a product resource.
* **Response:**
  * **Code:** 200
    **body:** `Product was successfully created `
* **API Key Required:**
`true`

**Update Product**
----
  update a product resource.
* **Response:**
  * **Code:** 200
    **body:** `Product was successfully updated `
* **API Key Required:**
`true`

**Delete Product**
----
  delete a product resource.
* **Response:**
  * **Code:** 200
    **body:** `Product was successfully deleted `
* **API Key Required:**
`true`


[architecture]: https://github.com/ajazfarhad/serverless-shop/raw/master/architecture.png "Architecture"

[response]: https://github.com/ajazfarhad/serverless-shop/raw/master/response.png "Response"
