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

    var Action = "Save";
    if (obj.id == "btnFinalize") {
        Action = 'Finalize';
    }
    else if (obj.id == "btnModification") {
        Action = 'ModificationNeeded';
    }
    else if (obj.id == "btnFinalizeByHod")
    {
        Action = 'FinalizedByHod';
    }
    else if(obj.id == "btnFinalizeByAssoDean")
    {
        Action = 'FinalizedByAssoDean';
    }
    else if (obj.id == "btnFinalizeByDean")
    {
        Action = 'FinalizedByDean';
    }
    var element = obj;

    var SerializeFormId = UrlConstant.SerializeFormID;
    //var data = $(SerializeFormId).serialize() + "&action=" + Action + "&menu=" + UrlConstant.Menu;

    var myData = {};
    myData.action = Action;
    myData.menu = UrlConstant.Menu;

    if (UrlConstant.Menu == "DOFA" || UrlConstant.Menu == "SRICFA" || UrlConstant.Menu == "SRIC") {
        myData.formData = $(SerializeFormId).serializeObject();
    }
    else {
        myData.formData = JSON.stringify($(SerializeFormId).serializeObject());
    }

    $.ajax({
        url: SaveUrlConstant.SaveUrl,
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        //dataType: "json",
        data: JSON.stringify(myData), //data,
        success: function (data, textStatus, jqXHR) {
            if (data.status == true) {
                setTimeout(function () {
                    window.location.href = window.location.href;
                },200);
                
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


