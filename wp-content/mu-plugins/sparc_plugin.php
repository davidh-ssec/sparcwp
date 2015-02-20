<?php
/*
Plugin Name: SPARC Plugin
Plugin URI: http://www.ssec.wisc.edu/software/sparc
Description: Provides features needed by the SPARC Theme created at the Space Science and Engineering Center (SSEC) at UW-Madison. This plugin provides post types and custom fields for proper theme visuals.
Version: 0.0.1
Author: David Hoese
Author URI: http://www.ssec.wisc.edu/software/sparc
*/

// Dave's Custom Stuff

add_action('init', 'cptui_register_my_cpt_experiment');
function cptui_register_my_cpt_experiment() {
register_post_type('experiment', array(
'label' => 'Experiments',
'description' => 'A field experiment',
'public' => true,
'show_ui' => true,
'show_in_menu' => true,
'capability_type' => 'post',
'map_meta_cap' => true,
'hierarchical' => false,
'rewrite' => array('slug' => 'experiment', 'with_front' => true),
'query_var' => true,
'supports' => array('title','editor','excerpt','trackbacks','custom-fields','comments','revisions','thumbnail','author','page-attributes','post-formats'),
'taxonomies' => array('category'),
'labels' => array (
  'name' => 'Experiments',
  'singular_name' => 'Experiment',
  'menu_name' => 'Experiments',
  'add_new' => 'Add Experiment',
  'add_new_item' => 'Add New Experiment',
  'edit' => 'Edit',
  'edit_item' => 'Edit Experiment',
  'new_item' => 'New Experiment',
  'view' => 'View Experiment',
  'view_item' => 'View Experiment',
  'search_items' => 'Search Experiments',
  'not_found' => 'No Experiments Found',
  'not_found_in_trash' => 'No Experiments Found in Trash',
  'parent' => 'Parent Experiment',
)
) ); }

add_action('init', 'cptui_register_my_cpt_field_post');
function cptui_register_my_cpt_field_post() {
register_post_type('field_post', array(
'label' => 'Field Posts',
'description' => 'Posts about a field event',
'public' => true,
'show_ui' => true,
'show_in_menu' => true,
'capability_type' => 'post',
'map_meta_cap' => true,
'hierarchical' => false,
'rewrite' => array('slug' => 'field_post', 'with_front' => true),
'query_var' => true,
'supports' => array('title','editor','excerpt','trackbacks','custom-fields','comments','revisions','thumbnail','author','page-attributes','post-formats'),
'taxonomies' => array('category'),
'labels' => array (
  'name' => 'Field Posts',
  'singular_name' => 'Field Post',
  'menu_name' => 'Field Posts',
  'add_new' => 'Add Field Post',
  'add_new_item' => 'Add New Field Post',
  'edit' => 'Edit',
  'edit_item' => 'Edit Field Post',
  'new_item' => 'New Field Post',
  'view' => 'View Field Post',
  'view_item' => 'View Field Post',
  'search_items' => 'Search Field Posts',
  'not_found' => 'No Field Posts Found',
  'not_found_in_trash' => 'No Field Posts Found in Trash',
  'parent' => 'Parent Field Post',
)
) ); }




// Only allow admins and super admins to see the "Advanced Custom Fields"
add_filter('acf/settings/show_admin', 'my_acf_show_admin');
function my_acf_show_admin( $show ) {
    return current_user_can('manage_options');
}

// Remove Posts Edit from the menu
add_action('admin_menu', 'my_remove_normal_posts');
function my_remove_normal_posts() {
    if (!current_user_can('manage_options')) {
        remove_menu_page('edit.php');
    }
}


function my_connection_types() {
    p2p_register_connection_type( array(
        'name' => 'field_post_to_experiment',
        'from' => 'field_post',
        'to' => 'experiment'
    ) );
}
add_action( 'p2p_init', 'my_connection_types' );



