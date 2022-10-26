//
// Copyright (c) Stewart H. Whitman, 2022.
//
// File:    wifi-plug.scad
// Project: WIFI Plug
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    WIFI Plug Model Parts
//

include <smidge.scad>

use <threadlib/threadlib.scad>
use <MCAD/regular_shapes.scad>
use <knurledFinishLib_v2_1.scad>

// Measurements taken from
//   Amphenol 132119RP
//   Ref: https://www.amphenolrf.com/132119rp.html

// Threads:
//   The Amphenol Document says
//     1/4"-36 UNS thread
//       Major diameter: 0.25" or 6.350mm, 36 TPI
//     https://www.gewinde-normen.de/en/unified-special-thread.html
//   We use coarse thread:
//     UNC 1/4"
//       Major diameter: 0.25" or 6.350mm, 20 TPI
//     https://www.gewinde-normen.de/en/unified-coarse-thread.html
//
// Flatten Thread Part:
//   The flat part is specified as 5.85mm flat, so we can use
//   a box that is
//

/* [General] */
// Show bolt, nut, cap, both
show_selection = "all"; // [ "all", "bolt", "nut", "cap" ]

// Scale percentage
scale_percentage = 103; // [ 90:1:110]

// Thread specification to use
common_thread_spec = "UNC-1/4";

// Head flats for bolt/nut, which also defines the outer diameter of the cap
common_head_hex_flats = 8.00; // [ 6.5:0.5:10.0 ]

/* [Bolt] */
// Bolt head thickness
bolt_head_thickness = 2.5; // [ 2:0.25:4 ]

// Bolt number of turns
bolt_turns = 4.5;	// [ 3:0.5:7 ]  

// Bolt actual diameter (should match thread library)
bolt_actual_diameter = 6.35;

// Bolt flat diameter
bolt_flat_diameter = 5.85;

/* [Nut] */
// Nut number of turns
nut_turns = 3; // [ 2:0.5:7 ]

/* [Cap] */
// Cap turns (should be about the same as Bolt turns, unless bulkhead is thick)
cap_turns = 4.5; // [ 3:0.5:7 ]

// Cap head thickness
cap_head_thickness = 2.5; // [ 2:0.25:4 ]

// Cap body knurling depth (or zero for no knurling)
cap_knurling_depth = 0.5; // [0:0.1:1.0]

// Library thread pitch is the same for either -int or -ext
function thread_pitch( spec ) = thread_specs( str(spec,"-ext") )[0];

// Library turns to height
function thread_turns_to_height(spec,turns,delta=1) = (turns+delta)*thread_pitch( spec );

// thread_level: move threaded children level with z=0
module thread_level_z(delta_z=0) { translate( [ 0,0, thread_pitch( common_thread_spec )/2+delta_z ] ) children(); }

// hex_flats_to_radius: convert hexagon flats to radius
function hex_flats_to_radius( across_flats ) = across_flats/2/cos(30);

// Common head/outer radius
common_head_hex_radius = hex_flats_to_radius( common_head_hex_flats ); 

// Common head/outer diameter
common_head_hex_diameter = 2*common_head_hex_radius;

// hex: create a 3-D hexagon of <radius> and <height>
module hex(radius,height)
{
  // create hex head 
  linear_extrude( height ) regular_polygon( 6, radius=radius );
} // end hex

// wifi_plug_bolt:
//
// This creates the flattened both with a hex head
//
module wifi_plug_bolt()
{
  bolt_thread_height = thread_turns_to_height( common_thread_spec, bolt_turns );

  translate( [0,0,bolt_head_thickness] )
    intersection() {
      // Normal bolt thread
      bolt(common_thread_spec, turns=bolt_turns, higbee_arc=30);

      // Flattening out one side
      {
	 d = bolt_actual_diameter; // 1/4"-36UNS diameter (6.35 mm)
	 h = bolt_flat_diameter;   // 5.85 mm flat
	 linear_extrude( height=bolt_thread_height )
	    translate( [d-h, 0] ) square( d, center=true );
      }
    }

  // Hex head
  hex( common_head_hex_radius, bolt_head_thickness );  
} // end wifi_plug_bolt

// wifi_plug_nut:
//
// This creates a matching hex nut
//
module wifi_plug_nut()
{
  nut_height = thread_turns_to_height( common_thread_spec, nut_turns );

  // Create a hex nut
  difference() {
    hex( common_head_hex_radius, nut_height-2*SMIDGE ); 
    thread_level_z(-SMIDGE)
      tap( common_thread_spec, turns=nut_turns );
  }
} // end wifi_plug_nut

// knurled_cylinder:
//
// Generate a knurled cylinder
//
module knurled_cylinder(d,h,kd)
{
  assert( kd >= 0 );

  if( kd == 0 )
    cylinder( h=h, d=d, $fn=120 );
  else {
    knurl_wd=2.0;    // Knurl polyhedron width
    knurl_hg=2.0;    // Knurl polyhedron height
    knurl_dp=kd;     // Knurl polyhedron depth

    k_cyl_hg=h;      // Knurled cylinder height
    k_cyl_od=d;      // Knurled cylinder outer diameter

    e_smooth=1;      // Cylinder ends smoothed height
    s_smooth=0;      // [ 0% - 100% ] Knurled surface smoothing amount

    knurled_cyl(k_cyl_hg, k_cyl_od,
		knurl_wd, knurl_hg, knurl_dp,
		e_smooth, s_smooth);
  }
} // end knurled_cylinder

// flip: Flip over height object
module flip(height)
{
  translate( [0,0,height] ) rotate( [180,0,0] ) children();
} // end flip

// wifi_plug_cap:
//
// This creates a cylindrical nut capped with a dome
//
module wifi_plug_cap()
{
  cap_outer_diameter = common_head_hex_diameter;
  cap_thread_height  = thread_turns_to_height( common_thread_spec, cap_turns );
  cap_height         = cap_thread_height+cap_head_thickness;

  // Flip for easier printing
  flip( cap_height ) 
    difference() {
      // Knurled cylinder
      knurled_cylinder( cap_outer_diameter, cap_height, cap_knurling_depth );

      // Tap
      thread_level_z(-SMIDGE)
	tap( common_thread_spec, turns=cap_turns );
    }
} // end wifi_plug_cap

//echo( "Pitch=", thread_pitch( common_thread_spec ) );

// show: Place a scale element at a <distance> from the origin, rotated <rotation> degrees
module show(rotation=0,distance=0)
{
  p = scale_percentage/100;
  rotate( rotation ) translate([distance,0,0]) scale([p,p,p]) children(); 
} // end show

show_distance = (show_selection == "all") ? 10 : 0;

if( show_selection == "bolt" || show_selection == "all" )
  show( 0, show_distance ) wifi_plug_bolt();

if( show_selection == "nut" || show_selection == "all" )
  show( 120, show_distance ) wifi_plug_nut();

if( show_selection == "cap" || show_selection == "all" )
  show( 240, show_distance ) wifi_plug_cap();
