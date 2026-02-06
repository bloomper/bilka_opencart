<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                <span class="pull-right"><?php echo $text_info; ?></span>
            </div>
            <div class="panel-body">
                <form method="post" action="<?php echo $action; ?>" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-order-id"><?php echo $entry_order_id; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="order_id" value="<?php echo isset($order_id) ? $order_id : ''; ?>" placeholder="<?php echo $entry_order_id; ?>" id="input-order-id" class="form-control" />
                            <span class="help-block"><?php echo $help_order_id; ?></span>
                            <?php if (isset($error_order_id) && $error_order_id) { ?>
                                <div class="text-danger"><?php echo $error_order_id; ?></div>
                            <?php } ?>
                            <button type="submit" id="button-activate" class="btn btn-primary"><i class="fa fa-key"></i> <?php echo $button_activate; ?></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
<?php echo $footer; ?>
</div>
