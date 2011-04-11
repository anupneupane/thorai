// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(function(){
	$("#new_discussion").submitWithAjax();
	$(".new_line_item").submitWithAjax();
	//$("#profile_birth_date").datepicker();
	$("#new_subscription").showSubscriptionModalDialog();
	$("#new_subscription").submitForm();
	//$("#new_subscription").closeModalDialog();
	$("#deal_preview").dealPreview();
})

jQuery.fn.submitWithAjax = function(){
	this.submit(function(){
		$.post(this.action, $(this).serialize(), null, "script");
		return false;
	})
}

jQuery.fn.dealPreview = function(){
	this.submit(function(){
		$.post(this.action, $(this).serialize(), null, "script");
		return false;
		this.showDealPreviewDialog();
	})
}

jQuery.fn.submitForm = function(){
	this.submit(function(){
		$.post(this.action, $(this).serialize(), null, "script");
		$.dialog('close')
		return true;
	})
}

jQuery.fn.showSubscriptionModalDialog = function(){
	this.dialog(
		{
			modal:true, 
			width:'auto',
			height:'auto',
			title: 'New to Purchest? Subscribe to deals that interest you!',
			
			close: function(event, ui) {
				top.location.href = 'https://radiant-meadow-885.heroku.com/';//http://localhost:3000/';
			}
		}
	)
}

jQuery.fn.showDealPreviewDialog = function(){
	this.dialog(
		{
			modal:true, 
			width:'auto',
			height:'auto',
			title: 'Deal Preview'
		}
	)
}

//jQuery.fn.closeModalDialog = function(){
	//this.close({
		
	//})
//}
