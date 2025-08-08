import sqlite3

def get_customer_purchase(first_name, last_name):
    conn = None 
    try:

        conn = sqlite3.connect('project.db')
        cursor = conn.cursor()
        

        cursor.execute(
            "SELECT customer_id FROM Customer WHERE first_name = ? AND last_name = ?",
            (first_name, last_name)
        )
        customer_id_result = cursor.fetchone()
        
        if customer_id_result:
            customer_id = customer_id_result[0]
            print(f"\nFound customer '{first_name} {last_name}' with ID: {customer_id}")

            cursor.execute(
                "SELECT SUM(total_price) FROM Purchase WHERE customer_id = ?",
                (customer_id,)
            )
            total_spending = cursor.fetchone()[0]
            
            return (f"{first_name} {last_name}", total_spending if total_spending else 0.0)
        else:
            return (None, None)
            
    except sqlite3.Error as e:
        print(f"Database error: {e}")
        return (None, None)
    finally:
        # Close the connection whether an error occurred or not
        if conn:
            conn.close()
def add_product(product_name):
    conn = None  # Initialize connection to None
    try:
        # Connect to the SQLite database
        conn = sqlite3.connect('project.db')
        cursor = conn.cursor()
        
        # SQL query to find the customer's ID by their first and last name
        # Using a parameterized query to prevent SQL injection
        cursor.execute(
            "SELECT * FROM Product WHERE product_name = ?",
            (product_name,)
        )
        product_result = cursor.fetchone()
        
        if not product_result:
            price = int(input("Price: "))
            stock = int(input("Stock: "))
            print(f"Adding new item into shelf: \nProduct Name: {product_name}\nPrice: {price}\nStock: {stock}")
            cursor.execute(
                """INSERT INTO PRODUCT(product_name, price, stock)
                    VALUES (?,?,?)
                """,
                (product_name,price,stock)
            )
            conn.commit()
            return True
        else:
            print(f"Product '{product_name}' already exists. Do you want to modify it ?: ")
            print("1: Yes")
            print("2: No")
            modify_choice = int(input("You choose: "))
            if (modify_choice == 1):
                price = int(input("New Price: "))
                stock = int(input("New Stock: "))
                cursor.execute(
                    """UPDATE PRODUCT
                       SET price = ?, stock = ?
                       WHERE product_name = ?
                    """,
                    (price,stock,product_name))
                conn.commit()
                return True
            else:
                return False
    except sqlite3.Error as e:
        print(f"Database error: {e}")
        return (None, None)
    finally:
        # Close the connection whether an error occurred or not
        if conn:
            conn.close()

if __name__ == "__main__":
    print("--- E-commerce System Activating---")
    print("Please choose your mode")
    print("Mode 1: Adding/Modifying Product into Shelf")
    print("Mode 2: Checking the purchase history of a customer")
    # Get user input for customer's name
    mode = input("Enter the mode: ")
    print("Please fill all the information")
    if (int(mode) == 1):
        product_name = input("Product Name: ")
        result = add_product(product_name)
    elif (int(mode) == 2):
        first = input("Enter customer's first name: ")
        last = input("Enter customer's last name: ")
        name, total = get_customer_purchase(first, last)
        if name:
            print(f"\nReport for {name}:")
            print(f"Total amount spent: ${total:.2f}")
        else:
            print(f"\nError: Customer '{first} {last}' not found in the database.")
    else:
        print("Your mode input is incorrect")
    # Call the function to get the spending data
    
    
    # Display the results

    print("\n--- End of Report ---")