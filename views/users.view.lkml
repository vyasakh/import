# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.users ;;
  #drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    drill_fields: [id]

  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    type: sum
    sql: ${age} ;;
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries

    sql: ${TABLE}.country ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.
dimension:new_maps{
  sql: "Rosario" ;;
  map_layer_name: new_maps
}
  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    drill_fields: [id]
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
#parameter: xx1x {
  parameter: geography_parameters_chart {
    type: unquoted
    default_value: "city"
    allowed_value: {
      label: "City"
      value: "city"
    }
    allowed_value: {
      label: "District"
      value: "district"
    }
    allowed_value: {
      label: "RFMA Segment"
      value: "segment"
    }
    allowed_value: {
      label: "Category"
      value: "category"
    }
    allowed_value: {
      label: "Sub Category"
      value: "scategory"
    }
    allowed_value: {
      label: "Principal"
      value: "prin"
    }
    allowed_value: {
      label: "Brand"
      value: "brand"
    }
    allowed_value: {
      label: "Outlet Type"
      value: "type"
    }
    allowed_value: {
      label: "Outlet Sub Type"
      value: "subtype"
    }
  }
  dimension: axis_selection {
    label: "Axis Selection"
    drill_fields: [id]
    type: string
    sql:{% if geography_parameters_chart._parameter_value == 'city' %}
          ${city}
          {% elsif geography_parameters_chart._parameter_value == 'district' %}
          ${state}
          {% elsif geography_parameters_chart._parameter_value == 'segment' %}
          ${first_name}
          {% elsif geography_parameters_chart._parameter_value == 'category' %}
          ${last_name}
          {% elsif geography_parameters_chart._parameter_value == 'scategory' %}
          ${country}
          {% elsif geography_parameters_chart._parameter_value == 'prin' %}
          ${email}
          {% elsif geography_parameters_chart._parameter_value == 'brand' %}
          ${gender}
          {% elsif geography_parameters_chart._parameter_value == 'type' %}
          ${last_name}
           {% elsif geography_parameters_chart._parameter_value == 'subtype' %}
          ${first_name}
          {% else %}
          ${city}
          {% endif %};;
  }

  measure: count {
    type: count
   # drill_fields: [detail*]
  }
measure: xx {
  type: number
  sql: ${id}+${count} ;;
}
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }
}
