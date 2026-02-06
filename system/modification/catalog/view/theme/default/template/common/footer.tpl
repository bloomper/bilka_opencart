<footer>
<?php if($custom_footer['status'] == 1) { ?>
			<?php if($custom_footer['footer_extra_heading_status1'] == 1 || $custom_footer['footer_extra_heading_status2'] == 1) { $col_sm = 'col-sm-2'; } else { $col_sm = 'col-sm-3';  }  ?> 
			<style type="text/css">
			footer{background-color:<?php echo isset($custom_footer['footer_bg_color']) ? $custom_footer['footer_bg_color'] : '#303030';?>; color:<?php echo isset($custom_footer['footer_link_color']) ? $custom_footer['footer_link_color'] : '#ccc';?>; }
footer h5{color:<?php echo isset($custom_footer['footer_heading_font_color']) ? $custom_footer['footer_heading_font_color'] : '#fff';?>; }
footer a{color:<?php echo isset($custom_footer['footer_link_color']) ? $custom_footer['footer_link_color'] : '#ccc';?>; }
footer a:hover{color:<?php echo isset($custom_footer['footer_link_hover_color']) ? $custom_footer['footer_link_hover_color'] : '#fff';?>; }
footer hr{border-color:<?php echo isset($custom_footer['footer_hr_color']) ? $custom_footer['footer_hr_color'] : '#fff';?>; }
			</style>
			<?php } ?>
  <div <?php if($custom_footer['status'] == 1) { ?> class="<?php echo ($custom_footer['footer_full_width']==1) ? 'container-fluid' : 'container';?>" <?php } else { ?> class="container" <?php } ?>>
    <div class="row">
 <?php if($custom_footer['status'] == 1) { ?> 
			<?php if($custom_footer['footer_google_map_status']==1 && $custom_footer['footer_google_map_position']=='top') { ?> <div><?php echo html_entity_decode($custom_footer['footer_google_map_embed_text'], ENT_QUOTES, 'UTF-8'); ?></div> <?php } ?>
		 <?php } ?> 
 <?php if($custom_footer['status'] == 1) { ?> 
			<?php for($x=1;$x<=2;$x++) { ?>
	  <?php if($custom_footer['footer_extra_heading_status'.$x]==1) { ?>
	  <div class="<?php echo $col_sm;?>">
        <h5><?php echo $custom_footer['footer_extra_heading_title'.$x]; ?></h5>
        <div><?php echo html_entity_decode($custom_footer['footer_extra_text'.$x], ENT_QUOTES, 'UTF-8'); ?></div>
		<ul class="list-unstyled">
			<?php for($i = 1; $i<=10; $i++) { ?>
			<?php if($custom_footer['custom_footer_link_display_in'.$i] == 'footer_extra_heading_'.$x && $custom_footer['custom_footer_link_status'.$i] == 1) { ?>
				<li><a href="<?php echo $custom_footer['custom_footer_link_url'.$i];?>"><?php echo $custom_footer['custom_footer_link_name'.$i];?></a></li>
			<?php } ?>
		 <?php } ?>
		</ul>
      </div>
	 <?php } ?>
	 <?php } ?>
	 	<?php } ?>
      <?php if ($informations) { ?>
      <div <?php if($custom_footer['status'] == 1) { ?> class="<?php echo $col_sm;?>" <?php } else { ?> class="col-sm-3" <?php } ?>>
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div <?php if($custom_footer['status'] == 1) { ?> class="<?php echo $col_sm;?>" <?php } else { ?> class="col-sm-3" <?php } ?>>
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
 <?php if($custom_footer['status'] == 1) { ?> 
			<?php for($i = 1; $i<=10; $i++) { ?>
			<?php if($custom_footer['custom_footer_link_display_in'.$i] == 'information' && $custom_footer['custom_footer_link_status'.$i] == 1) { ?>
				<li><a href="<?php echo $custom_footer['custom_footer_link_url'.$i];?>"><?php echo $custom_footer['custom_footer_link_name'.$i];?></a></li>
			<?php } ?>
		 <?php } ?> 
		 <?php } ?> 
        </ul>
      </div>
      <div <?php if($custom_footer['status'] == 1) { ?> class="<?php echo $col_sm;?>" <?php } else { ?> class="col-sm-3" <?php } ?>>
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          
          
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
 <?php if($custom_footer['status'] == 1) { ?> 
			 <?php for($i = 1; $i<=10; $i++) { ?>
			<?php if($custom_footer['custom_footer_link_display_in'.$i] == 'customer_service' && $custom_footer['custom_footer_link_status'.$i] == 1) { ?>
				<li><a href="<?php echo $custom_footer['custom_footer_link_url'.$i];?>"><?php echo $custom_footer['custom_footer_link_name'.$i];?></a></li>
			<?php } ?>
		 <?php } ?>
		 <?php } ?> 
        </ul>
      </div>
      <div <?php if($custom_footer['status'] == 1) { ?> class="<?php echo $col_sm;?>" <?php } else { ?> class="col-sm-3" <?php } ?>>
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          
          
 <?php if($custom_footer['status'] == 1) { ?> 
			<?php for($i = 1; $i<=10; $i++) { ?>
			<?php if($custom_footer['custom_footer_link_display_in'.$i] == 'extras' && $custom_footer['custom_footer_link_status'.$i] == 1) { ?>
				<li><a href="<?php echo $custom_footer['custom_footer_link_url'.$i];?>"><?php echo $custom_footer['custom_footer_link_name'.$i];?></a></li>
			<?php } ?>
		 <?php } ?>
		 <?php } ?> 
        </ul>
      </div>
    </div>
     <?php if($custom_footer['status'] == 1) { ?> 	 
	 <?php if($custom_footer['footer_google_map_status']==1 && $custom_footer['footer_google_map_position']=='bottom') { ?> <div><?php echo html_entity_decode($custom_footer['footer_google_map_embed_text'], ENT_QUOTES, 'UTF-8'); ?></div> <?php } ?>
	 
	 <?php if($custom_footer['footer_custom_content_status']==1) { ?> <div><?php echo html_entity_decode($custom_footer['footer_custom_content'], ENT_QUOTES, 'UTF-8'); ?></div> <?php } ?>
    
	 <?php if($custom_footer['footer_hr_status']==1) { ?> 
				<br />
			 <?php } ?>
	 
		 <?php } else { ?> 
				<br />
			 <?php } ?>
     <?php if($custom_footer['status'] == 1) { ?> 
			<?php if($custom_footer['footer_powered_by_text_status']==1) { ?> <div><?php echo html_entity_decode($custom_footer['footer_powered_by_text'], ENT_QUOTES, 'UTF-8'); ?></div> <?php } ?>
		 <?php } else { ?>   <?php } ?>
  </div>
</footer>






<?php echo $google_consent_v2; ?>

<?php if( $maintenance ) { ?>
<style type="text/css">
body { background-image:url(catalog/view/theme/default/image/maintenance.png); background-position:center; background-repeat:no-repeat; background-size:100%; background-attachment:fixed; }
</style>				
<?php } ?>
			
</body></html>