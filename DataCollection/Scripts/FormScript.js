function bindDataCaptYMChangeEvent()
{    
    $("#DataCaptYM").val($("#DataCaptYMhid").val());
    if ($("#DataCaptYMhid").val() > 0)
    {
        $("#buttonUL").show();
    }

    $("#DataCaptYM").change(function () {
        getDataCaptYearData();
    });
}

function getDataCaptYearData()
{
    $("#DataCaptYMhid").val($("#DataCaptYM").val());

    if (UrlConstant.Menu != '-1' && UrlConstant.Menu != '') {
        $.post("/Forms/OnDAtaCaptYMChange",
        {
            DataCaptYM: $("#DataCaptYM").val().toString(),
            Menu: UrlConstant.Menu,
            DeptID: MenuConstant.IsAdmin ? $("#DepartmentsDDL").val() : MenuConstant.DeptId
        },
        function (data) {
            var tableDivId = UrlConstant.TableDivID;
            $(tableDivId).html("");
            $(tableDivId).html(data);
            if ($("#DataCaptYM").val() > 0) {
                $("#buttonUL").show();
            } else {
                $("#buttonUL").hide();
            }
        });
    }
}

function bindCalculateTotal(obj)
{
    var num = obj.value.match(/^\d+$/);
    if (num === null) {
        obj.value = "";
    }
    else {
        CalculateTotal();
    }
}

function setTooltip(el) {
    if (!el) {
        $("input.edit-value").tooltip();
        $("a.deletenew").tooltip();
    }
    else {
        $(el).find("input.edit-value").tooltip();
        $(el).find("a.deletenew").tooltip();
    }   
}

function CalculateTotal() {
    var result = [];
    $('table tbody#detailofstd tr').each(function () {
        $('td input[type="number"]', this).each(function (index, val) {
            if (!result[index]) result[index] = 0;
            if ($(val).val() != "") {
                result[index] += parseInt($(val).val());
            }
        });
    });
    $('#UgftTotal').val(result[0]);
    $('#Ug5ftTotal').val(result[1]);
    $('#PgftTotal').val(result[2]);
    $('#PgptTotal').val(result[3]);
}

function setAction(obj)
{
    debugger;
    var Action = "Save";
    if (obj.id == "btnFinalize") {
        Action = 'Finalize';
    }
    else if (obj.id == "btnModificationHod") {
        Action = 'ModificationNeededHod';
    }
    else if (obj.id == "btnModificationADean") {
        Action = 'ModificationNeededADean';
    }
    else if (obj.id == "btnModificationDean") {
        Action = 'ModificationNeededDean';
    }
    else if (obj.id == "btnFinalizedByHod") {
        Action = 'FinalizedByHod';
    }
    else if (obj.id == "btnFinalizedByAssoDean") {
        Action = 'FinalizedByAssoDean';
    }
    else if (obj.id == "btnFinalizedByDean") {
        Action = 'FinalizedByDean';
    }
    else if (obj.id == "btnFinalizedByDean") {
        Action = 'FinalizedByDean';
    }

    return Action;
}

function SaveFormData(e, obj) {   
    $("#jsErrorDiv").hide();
    e.preventDefault(); //stop default behaviour of button
    var DataCaptYMhid = $("#DataCaptYMhid").val();
    if (DataCaptYMhid == '0') {
        $("#jsErrorDiv strong").html("");
        $("#jsErrorDiv strong").html("Please check data captured year from list.");
        $("#jsErrorDiv").show();
        if (obj.id == "btnFinalize") {
            $("#myModal").modal("hide");
        }
        return false;
    }

    var Action = setAction(obj);
    var element = obj;
    var SerializeFormId = UrlConstant.SerializeFormID;

    var myData = {};
    myData.action = Action;
    myData.menu = UrlConstant.Menu;
    myData.needModificationMSG = $("#NeedModificationMSG").val();

    if (UrlConstant.Menu == "DOFA" || UrlConstant.Menu == "SRICFA" || UrlConstant.Menu == "SRIC" || UrlConstant.Menu == "DOFAPEER") {
        if (UrlConstant.Menu == "DOFAPEER") {
            $(".empNo").removeAttr("disabled");
            myData.formData = $(SerializeFormId).serializeObject();
            $(".empNo").attr("disabled", "disabled");
        } else {
            myData.formData = $(SerializeFormId).serializeObject();
        }
    }
    else {
        myData.formData = JSON.stringify($(SerializeFormId).serializeObject());
    }

    $.ajax({
        url: SaveUrlConstant.SaveUrl,
        type: "POST",        
        contentType: 'application/json; charset=utf-8',    
        data: JSON.stringify(myData), 
        success: function (data, textStatus, jqXHR) {
            if (data.status == true) {
                if (UrlConstant.Menu == "DOFAPEER") {
                    LoadEmpData(true);
                } else {
                    setTimeout(function () {
                        window.location.href = window.location.href;
                    }, 200);
                }
            } else {
                if (data.msg && data.msg.length > 0) {
                    if ($("#alertMsgSpan").length > 0) {
                        $("#alertMsgSpan").html(data.msg);
                        $("#ErrorAlertModel").modal("show");
                    }
                    else {
                        alert(data.msg);
                    }
                }
                else {
                    if ($("#alertMsgSpan").length > 0) {
                        $("#alertMsgSpan").html("Error occurs on the Database level!");
                        $("#ErrorAlertModel").modal("show");
                    }
                    else {
                        alert("Error occurs on the Database level!");
                    }
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert("An error has occured!!!");
        }
    });
}

$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};


