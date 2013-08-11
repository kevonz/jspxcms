Cms.f7 = {};
/**
 * 节点单选
 */
Cms.f7.node = function(ctx, name, options) {
	var url = ctx + "/cmscp/core/node/f7_node_tree.do";
	var idHidden = $("#" + name);
	var numberHidden = $("#" + name + "Number");
	var nameHidden = $("#" + name + "Name");
	var numberDisplay = $("#" + name + "NumberDisplay");
	var nameDisplay = $("#" + name + "NameDisplay");
	var f7Button = $("#" + name + "Button");
	var dialogDiv = null;

	var destroy = function() {
		dialogDiv.dialog("destroy");
		dialogDiv.empty();
	};
	var applayValue = function() {
		var id = $("#_f7_id").val();
		idHidden.val(id);
		numberHidden.val(id);
		numberDisplay.val(id);
		var name = $("#_f7_name").val();
		nameHidden.val(name);
		if(nameDisplay.length>0) {
			nameDisplay.is("input")?nameDisplay.val(name):nameDisplay.text(name);
		} else {
			numberDisplay.val(name);
		}
		nameDisplay.focus();
		numberDisplay.focus();
	};

	var settings = {
		title : "Select Node",
		width : 300,
		height : 400,
		modal : true,
		position : {
			my : "center top",
			at : "center top",
			of : window
		},
		buttons : [ {
			id : "_f7_ok",
			text : "OK",
			click : function() {
				applayValue();
				destroy();
				if(options && options.ok && typeof options.ok=="function") {
					options.ok(idHidden.val(),numberHidden.val(),nameHidden.val());
				}
			}
		}, {
			text : "Cancel",
			click : function() {
				destroy();
				if(options && options.cancel && typeof options.cancel=="function") {
					options.cancel();
				}
			}
		} ]
	};
	$.extend(settings, options);

	f7Button.click(function() {
		var params = {"d":new Date()*1};
		if(idHidden.val()!="") {
			params.id = idHidden.val();
		}
		params = $.extend(settings.params,params);
		if (!dialogDiv) {
			dialogDiv = $("<div style='display:none;'>").appendTo(document.body);
		}
		dialogDiv.load(url + "?" + $.param(params), function() {
			dialogDiv.dialog(settings);
		});
	});
};

/**
 * 节点多选
 */
Cms.f7.nodeMulti = function(ctx, name, options) {
	var url = ctx + "/cmscp/core/node/f7_node_tree_multi.do";
	var idHidden = $("#" + name);
	var numberHidden = $("#" + name + "Number");
	var nameHidden = $("#" + name + "Name");
	var numberDisplay = $("#" + name + "NumberDisplay");
	var nameDisplay = $("#" + name + "NameDisplay");
	var f7Button = $("#" + name + "Button");
	var dialogDiv = null;
	var ids = [];
	var numbers = [];
	var names = [];
	
	var init = function() {
		idHidden.find("input[name='"+name+"']").each(function() {
			ids[ids.length] = $(this).val();
		});
		numberHidden.find("input[name='"+name+"Number']").each(function() {
			numbers[numbers.length] = $(this).val();
			numberDisplay.val(numberDisplay.val()+","+$(this).val());
		});
		nameHidden.find("input[name='"+name+"Name']").each(function() {
			names[names.length] = $(this).val();
			nameDisplay.val(nameDisplay.val()+","+$(this).val());
		});
		if(numberDisplay.length>0) {
			var numberValue = numberDisplay.val();
			var numberValueLength = numberValue.length;
			if(numberValueLength>0) {
				numberDisplay.val(numberValue.substring(1,numberValueLength));
			}			
		}
		if(nameDisplay.length>0) {
			var nameValue = nameDisplay.val();
			var nameValueLength = nameValue.length;
			if(nameValueLength>0) {
				nameDisplay.val(nameValue.substring(1,nameValueLength));
			}			
		}	
	};
	init();

	var destroy = function() {
		dialogDiv.dialog("destroy");
		dialogDiv.empty();
	};
	var applayValue = function() {
		idHidden.empty();
		numberHidden.empty();
		nameHidden.empty();
		numberDisplay.val("");
		nameDisplay.val("");
		ids = [];
		numbers = [];
		names = [];
		$("input[name='f7_ids']").each(function() {
			ids[ids.length] = $(this).val();
			idHidden.append("<input type='hidden' name='"+name+"' value='"+$(this).val()+"'/>");
		});
		$("input[name='f7_numbers']").each(function() {
			numbers[numbers.length] = $(this).val();
			numberHidden.append("<input type='hidden' name='"+name+"Number' value='"+$(this).val()+"'/>");
			numberDisplay.val(numberDisplay.val()+","+$(this).val());
		});
		$("input[name='f7_names']").each(function() {
			names[names.length] = $(this).val();
			nameHidden.append("<input type='hidden' name='"+name+"Name' value='"+$(this).val()+"'/>");
			nameDisplay.val(nameDisplay.val()+","+$(this).val());
		});
		if(numberDisplay.length>0) {
			var numberValue = numberDisplay.val();
			var numberValueLength = numberValue.length;
			if(numberValueLength>0) {
				numberDisplay.val(numberValue.substring(1,numberValueLength));
			}			
		}
		if(nameDisplay.length>0) {
			var nameValue = nameDisplay.val();
			var nameValueLength = nameValue.length;
			if(nameValueLength>0) {
				nameDisplay.val(nameValue.substring(1,nameValueLength));
			}			
		}
		nameDisplay.focus();
		numberDisplay.focus();
	};

	var settings = {
		title : "Select Node",
		width : 550,
		height : 400,
		modal : true,
		position : {
			my : "center top",
			at : "center top",
			of : window
		},
		buttons : [ {
			id : "_f7_ok",
			text : "OK",
			click : function() {
				applayValue();
				destroy();
				if(options && options.ok && typeof options.ok=="function") {
					options.ok(ids,numbers,names);
				}
			}
		}, {
			text : "Cancel",
			click : function() {
				destroy();
				if(options && options.cancel && typeof options.cancel=="function") {
					options.cancel(ids,numbers,names);
				}
			}
		} ]
	};
	$.extend(settings, options);

	f7Button.click(function() {
		var params = {"d":new Date()*1};
		params.ids = [];
		$("input[name='"+name+"']").each(function() {
			params.ids[params.ids.length] = $(this).val();
		});
		params = $.extend(settings.params,params);
		if (!dialogDiv) {
			dialogDiv = $("<div style='display:none;'>").appendTo(document.body);
		}
		dialogDiv.load(url + "?" + $.param(params,true), function() {
			dialogDiv.dialog(settings);
		});
	});
};
/**
 * 专题多选
 */
Cms.f7.specialMulti = function(ctx, name, options) {
	var url = ctx + "/cmscp/core/special/f7_special_multi.do";
	var idHidden = $("#" + name);
	var numberHidden = $("#" + name + "Number");
	var nameHidden = $("#" + name + "Name");
	var numberDisplay = $("#" + name + "NumberDisplay");
	var nameDisplay = $("#" + name + "NameDisplay");
	var f7Button = $("#" + name + "Button");
	var dialogDiv = null;
	var ids = [];
	var numbers = [];
	var names = [];
	var init = function() {
		idHidden.find("input[name='"+name+"']").each(function() {
			ids[ids.length] = $(this).val();
		});
		numberHidden.find("input[name='"+name+"Number']").each(function() {
			numbers[numbers.length] = $(this).val();
			numberDisplay.val(numberDisplay.val()+","+$(this).val());
		});
		nameHidden.find("input[name='"+name+"Name']").each(function() {
			names[names.length] = $(this).val();
			nameDisplay.val(nameDisplay.val()+","+$(this).val());
		});
		if(numberDisplay.length>0) {
			var numberValue = numberDisplay.val();
			var numberValueLength = numberValue.length;
			if(numberValueLength>0) {
				numberDisplay.val(numberValue.substring(1,numberValueLength));
			}			
		}
		if(nameDisplay.length>0) {
			var nameValue = nameDisplay.val();
			var nameValueLength = nameValue.length;
			if(nameValueLength>0) {
				nameDisplay.val(nameValue.substring(1,nameValueLength));
			}			
		}	
	};
	init();

	var destroy = function() {
		dialogDiv.dialog("destroy");
		dialogDiv.empty();
	};
	var applayValue = function() {
		idHidden.empty();
		numberHidden.empty();
		nameHidden.empty();
		numberDisplay.val("");
		nameDisplay.val("");
		ids = [];
		numbers = [];
		names = [];
		$("input[name='f7_ids']").each(function() {
			ids[ids.length] = $(this).val();
			idHidden.append("<input type='hidden' name='"+name+"' value='"+$(this).val()+"'/>");
		});
		$("input[name='f7_numbers']").each(function() {
			numbers[numbers.length] = $(this).val();
			numberHidden.append("<input type='hidden' name='"+name+"Number' value='"+$(this).val()+"'/>");
			numberDisplay.val(numberDisplay.val()+","+$(this).val());
		});
		$("input[name='f7_names']").each(function() {
			names[names.length] = $(this).val();
			nameHidden.append("<input type='hidden' name='"+name+"Name' value='"+$(this).val()+"'/>");
			nameDisplay.val(nameDisplay.val()+","+$(this).val());
		});
		if(numberDisplay.length>0) {
			var numberValue = numberDisplay.val();
			var numberValueLength = numberValue.length;
			if(numberValueLength>0) {
				numberDisplay.val(numberValue.substring(1,numberValueLength));
			}			
		}
		if(nameDisplay.length>0) {
			var nameValue = nameDisplay.val();
			var nameValueLength = nameValue.length;
			if(nameValueLength>0) {
				nameDisplay.val(nameValue.substring(1,nameValueLength));
			}			
		}
		nameDisplay.focus();
		numberDisplay.focus();
	};

	var settings = {
		title : "Select Node",
		width : 550,
		height : 400,
		modal : true,
		position : {
			my : "center top",
			at : "center top",
			of : window
		},
		buttons : [ {
			id : "_f7_ok",
			text : "OK",
			click : function() {
				applayValue();
				destroy();
				if(options && options.ok && typeof options.ok=="function") {
					options.ok(ids,numbers,names);
				}
			}
		}, {
			text : "Cancel",
			click : function() {
				destroy();
				if(options && options.cancel && typeof options.cancel=="function") {
					options.cancel(ids,numbers,names);
				}
			}
		} ]
	};
	$.extend(settings, options);

	f7Button.click(function() {
		var params = {"d":new Date()*1};
		params.ids = [];
		$("input[name='"+name+"']").each(function() {
			params.ids[params.ids.length] = $(this).val();
		});
		params = $.extend(settings.params,params);
		if (!dialogDiv) {
			dialogDiv = $("<div style='display:none;'>").appendTo(document.body);
		}
		dialogDiv.load(url + "?" + $.param(params,true), function() {
			dialogDiv.dialog(settings);
		});
	});
};
Cms.F7Multi = function(url, name, options) {
	var idHidden = $("#" + name);
	var numberHidden = $("#" + name + "Number");
	var nameHidden = $("#" + name + "Name");
	var numberDisplay = $("#" + name + "NumberDisplay");
	var nameDisplay = $("#" + name + "NameDisplay");
	var f7Button = $("#" + name + "Button");
	var dialogDiv = null;
	var ids = [];
	var numbers = [];
	var names = [];
	var init = function() {
		idHidden.find("input[name='"+name+"']").each(function() {
			ids[ids.length] = $(this).val();
		});
		numberHidden.find("input[name='"+name+"Number']").each(function() {
			numbers[numbers.length] = $(this).val();
			numberDisplay.val(numberDisplay.val()+","+$(this).val());
		});
		nameHidden.find("input[name='"+name+"Name']").each(function() {
			names[names.length] = $(this).val();
			nameDisplay.val(nameDisplay.val()+","+$(this).val());
		});
		if(numberDisplay.length>0) {
			var numberValue = numberDisplay.val();
			var numberValueLength = numberValue.length;
			if(numberValueLength>0) {
				numberDisplay.val(numberValue.substring(1,numberValueLength));
			}			
		}
		if(nameDisplay.length>0) {
			var nameValue = nameDisplay.val();
			var nameValueLength = nameValue.length;
			if(nameValueLength>0) {
				nameDisplay.val(nameValue.substring(1,nameValueLength));
			}			
		}	
	};
	init();

	var destroy = function() {
		dialogDiv.dialog("destroy");
		dialogDiv.empty();
	};
	var applayValue = function() {
		idHidden.empty();
		numberHidden.empty();
		nameHidden.empty();
		numberDisplay.val("");
		nameDisplay.val("");
		ids = [];
		numbers = [];
		names = [];
		$("input[name='f7_ids']").each(function() {
			ids[ids.length] = $(this).val();
			idHidden.append("<input type='hidden' name='"+name+"' value='"+$(this).val()+"'/>");
		});
		$("input[name='f7_numbers']").each(function() {
			numbers[numbers.length] = $(this).val();
			numberHidden.append("<input type='hidden' name='"+name+"Number' value='"+$(this).val()+"'/>");
			numberDisplay.val(numberDisplay.val()+","+$(this).val());
		});
		$("input[name='f7_names']").each(function() {
			names[names.length] = $(this).val();
			nameHidden.append("<input type='hidden' name='"+name+"Name' value='"+$(this).val()+"'/>");
			nameDisplay.val(nameDisplay.val()+","+$(this).val());
		});
		if(numberDisplay.length>0) {
			var numberValue = numberDisplay.val();
			var numberValueLength = numberValue.length;
			if(numberValueLength>0) {
				numberDisplay.val(numberValue.substring(1,numberValueLength));
			}			
		}
		if(nameDisplay.length>0) {
			var nameValue = nameDisplay.val();
			var nameValueLength = nameValue.length;
			if(nameValueLength>0) {
				nameDisplay.val(nameValue.substring(1,nameValueLength));
			}			
		}
		nameDisplay.focus();
		numberDisplay.focus();
	};

	var settings = {
		title : "F7 Multi Select",
		width : 550,
		height : 400,
		modal : true,
		position : {
			my : "center top",
			at : "center top",
			of : window
		},
		buttons : [ {
			id : "_f7_ok",
			text : "OK",
			click : function() {
				applayValue();
				destroy();
				if(options && options.ok && typeof options.ok=="function") {
					options.ok(ids,numbers,names);
				}
			}
		}, {
			text : "Cancel",
			click : function() {
				destroy();
				if(options && options.cancel && typeof options.cancel=="function") {
					options.cancel(ids,numbers,names);
				}
			}
		} ]
	};
	$.extend(settings, options);

	f7Button.click(function() {
		var params = {"d":new Date()*1};
		params.ids = [];
		$("input[name='"+name+"']").each(function() {
			params.ids[params.ids.length] = $(this).val();
		});
		params = $.extend(settings.params,params);
		if (!dialogDiv) {
			dialogDiv = $("<div style='display:none;'>").appendTo(document.body);
		}
		dialogDiv.load(url + "?" + $.param(params,true), function() {
			dialogDiv.dialog(settings);
		});
	});
};
Cms.F7Single = function(url, name, options) {
	var idHidden = $("#" + name);
	var numberHidden = $("#" + name + "Number");
	var nameHidden = $("#" + name + "Name");
	var numberDisplay = $("#" + name + "NumberDisplay");
	var nameDisplay = $("#" + name + "NameDisplay");
	var f7Button = $("#" + name + "Button");
	var dialogDiv = null;

	var destroy = function() {
		dialogDiv.dialog("destroy");
		dialogDiv.empty();
	};
	var applayValue = function() {
		var id = $("#_f7_id").val();
		var number = $("#_f7_number").val();
		var name = $("#_f7_name").val();
		idHidden.val(id);
		numberHidden.val(number);
		numberDisplay.val(number);
		nameHidden.val(name);
		nameDisplay.val(name);
	};
	var focus = function() {
		if(numberDisplay.length>0) {
			numberDisplay.focus();
		} else if(nameDisplay.length>0) {
			nameDisplay.focus();
		} else if(numberHidden.length>0) {
			numberHidden.focus();
		}
	};

	var settings = {
		title : "F7 Select",
		width : 300,
		height : 400,
		modal : true,
		position : {
			my : "center top",
			at : "center top",
			of : window
		},
		buttons : [ {
			id : "_f7_ok",
			text : "OK",
			click : function() {
				applayValue();
				destroy();
				if(options && options.ok && typeof options.ok=="function") {
					options.ok(idHidden.val(),numberHidden.val(),nameHidden.val());
				}
				focus();
			}
		}, {
			text : "Cancel",
			click : function() {
				destroy();
				if(options && options.cancel && typeof options.cancel=="function") {
					options.cancel();
				}
				focus();
			}
		} ]
	};
	$.extend(settings, options);

	f7Button.click(function() {
		var params = {"d":new Date()*1};
		if(idHidden.val()!="") {
			params.id = idHidden.val();
		}
		params = $.extend(settings.params,params);
		if (!dialogDiv) {
			dialogDiv = $("<div style='display:none;'>").appendTo(document.body);
		}
		dialogDiv.load(url + "?" + $.param(params), function() {
			dialogDiv.dialog(settings);
		});
	});
};
/**
 * 权限多选
 */
Cms.f7.perm = function(ctx, name, options) {
	var url = ctx + "/cmscp/core/role/f7_perm_tree.do";
	var settings = {title:"Perm Select",width:300,height:400};
	$.extend(settings, options);
	var f7 = Cms.F7Single(url,name,settings);
};