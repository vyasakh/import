view: new11 {

   sql_table_name: demo_db.{{ _user_attributes['new11'] }} ;;
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;

  }

  dimension: gen {
    type: string
    sql: ${TABLE}.gen ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.


  measure: count {
    type: count
  }
  }