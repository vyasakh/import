# The name of this view in Looker is "Dept"
view: dept {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.dept ;;
  drill_fields: [dept_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: dept_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DeptID ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Dept Name" in Explore.

  dimension: dept_name {
    type: string
    sql: ${TABLE}.DeptName ;;
  }

  measure: count {
    type: count
    drill_fields: [dept_id, dept_name, salary.count]
  }
}
