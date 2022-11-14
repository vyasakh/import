view: sql_runner_query {
  derived_table: {
    sql: SELECT
          order_items.id  AS `order_items.id`,
          COUNT(*) AS `order_items.count`
      FROM demo_db.order_items  AS order_items
     where
     IF(CAST(({% condition xx %} order_items.id {% endcondition %}) AS STRING) = '1=1' then
    order_items.id=1;
    ELSE
    {% condition xx %} order_items.id {% endcondition %} ;


      GROUP BY
          1
      ORDER BY
          COUNT(*) DESC
      LIMIT 500
       ;;
  }
filter: xx {
  type: number
}
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_id {
    type: number
    sql: ${TABLE}.`order_items.id` ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  set: detail {
    fields: [order_items_id, order_items_count]
  }
}
