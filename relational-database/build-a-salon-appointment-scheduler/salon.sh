#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU() {
    if [[ $1 ]]; then
        echo -e "\n$1"
    fi

    echo "Welcome to My Salon, how can I help you?"

    AVAILABLE_SERVICES=$($PSQL "select service_id, name from services")

    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME; do
        echo "$SERVICE_ID) $NAME"
    done

    read SERVICE_ID_SELECTED

    # if input is not a number
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
        MAIN_MENU "That is not a valid bike number."
    else
        SERVICE_AVAILABILITY=$($PSQL "select * from services where service_id = $SERVICE_ID_SELECTED")

        if [[ -z $SERVICE_AVAILABILITY ]]; then
            MAIN_MENU "I could not find that service."
        else
            echo -e "\nWhat's your phone number?"
            read CUSTOMER_PHONE

            CUSTOMER_NAME=$($PSQL "select name from customers where phone = '$CUSTOMER_PHONE'")

            if [[ -z $CUSTOMER_NAME ]]
            then
                echo "I don't have a record for that phone number, what's your name?"
                read CUSTOMER_NAME

                INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers(phone, name) values ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
            fi

            CUSTOMER_ID=$($PSQL "select customer_id from customers where phone = '$CUSTOMER_PHONE'")
            SERVICE_NAME=$($PSQL "select name from services where service_id = $SERVICE_ID_SELECTED")

            echo "What time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
            read SERVICE_TIME
           
            INSERT_APPOINTMENT=$($PSQL "insert into appointments (customer_id, service_id, time) values ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

            echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
        fi
    fi
}

MAIN_MENU
