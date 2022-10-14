#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


echo -e "\n~~~~~ My Fashion Salon ~~~~~\n"


MAIN_MENU() {
  # in case, print the message
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Welcome, how can I help you?"

  echo -e "\n1) Cut\n2) Color\n3) Trim\n4) Exit"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) APPO_MENU ;;
    2) APPO_MENU ;;
    3) APPO_MENU ;;
    4) EXIT ;;

    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

APPO_MENU() {
  echo -e "\nPlease enter your phone:"
  read CUSTOMER_PHONE

  # get the asociate customer
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  
  # if not exist
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nPlease enter your name:"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    
    # update the empty value
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  fi

  # get time of appointment
  echo -e "\nPlease enter your desire time for the appointment:"
  read SERVICE_TIME


  # insert the appointment
  INSERT_APPO=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")


  # Message-out
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  SERVICE_NAME_FORMATED=$(echo $SERVICE_NAME | sed 's/ //')
  
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  CUSTOMER_NAME_FORMATED=$(echo $CUSTOMER_NAME | sed 's/ //')

  
  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATED."

}


EXIT() {
  echo -e "\nThank you for trusting us.\n"
}


MAIN_MENU

