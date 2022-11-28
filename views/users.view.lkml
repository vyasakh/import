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
   # suggest_persist_for: "5 hours"
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
  filter: current_month {
    type: date
  }
  dimension: is_current_month {
    type: yesno
    sql: {% condition current_month %} ${created_month} {% endcondition %} ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: license_start {
    type: date
    sql: ${created_date} ;;
    html: {{ rendered_value | date: "%m/%d/%Y" }} ;;
  }
  dimension: license_start1 {
    type: date_time
    sql: ${created_date} ;;
    html: {{ rendered_value | date: "%m/%d/%Y" }} ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    drill_fields: [id]
  }

  dimension: gen {
    type: string
    sql: ${TABLE}.gen ;;
  }

# This is correct

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    link: {

    label: "url"

     url:"https://gcpl2218.cloud.looker.com/looks/126?f[users.state]={{ _filters['users.state'] | url_encode }}&f[users.city]={{ _filters['users.city'] | url_encode }}"
    }

  }

  dimension: state_flag_image {
    type: string
    sql: ${state} ;;
    html:
              {% if state._value == "California" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/0/01/Flag_of_California.svg" height="170" width="255">
              {% elsif state._value == "New York" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_New_York.svg/1200px-Flag_of_New_York.svg.png" height="170" width="255">
              {% elsif state._value == "Colorado" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Flag_of_Colorado.svg/255px-Flag_of_Colorado.svg.png" height="170" width="255">
              {% elsif state._value == "Illinois"%}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Illinois.svg/1200px-Flag_of_Illinois.svg.png" height="170" width="255">
              {% else %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png" height="170" width="170">
              {% endif %} ;;
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
          ${gen}
          {% elsif geography_parameters_chart._parameter_value == 'type' %}
          ${last_name}
           {% elsif geography_parameters_chart._parameter_value == 'subtype' %}
          ${first_name}
          {% else %}
          ${first_name}
          {% endif %};;
  }
parameter: date {
  type: date
}
  measure: count {
    type: count
   drill_fields: [detail*]
  html: <a href="https://gcpl2218.cloud.looker.com/explore/vysakh_import_test/users?fields=users.state,users.count&f[users.state]={{ _filters['users.state'] | url_encode }}">{{value}}</a> ;;
  }
measure: xx {
  type: number
  sql: ${id}+${count} ;;
  html: <d>{{count._value}}</d> ;;
}
  measure: last_updated_date {
    type: date
    sql: MAX(${created_date}) ;;
    convert_tz: no
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