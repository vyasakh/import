- dashboard: attribute
  title: attribute
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  filters_bar_collapsed: true
  filters_location_top: false
  preferred_slug: T4WktIlR76WedIjaoZdSsT
  elements:
  - title: attribute
    name: attribute
    model: vysakh_import_test
    explore: users
    type: looker_column
    fields: [users.state, users.count]
    filters: {}
    sorts: [users.count desc]
    limit: 500
    query_timezone: Asia/Kolkata
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      State: users.state
      City: users.city
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: popover
    model: vysakh_import_test
    explore: users
    listens_to_filters: []
    field: users.state
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: popover
    model: vysakh_import_test
    explore: users
    listens_to_filters: []
    field: users.city
