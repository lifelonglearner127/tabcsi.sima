$('#users-table').DataTable({
    // dom: 'lfrtip',
    "dom": "<'mdl-grid'<'mdl-cell mdl-cell--6-col d-mobile-hidden'i><'mdl-cell mdl-cell--6-col'f>>t<'mdl-grid'<'mdl-cell mdl-cell--8-col'A>>",
    "searching": true, // false to disable search (or any other option)
    "ordering": false,
    // "pagingType": "first_last_numbers",
    stateSave: true,
    // "lengthMenu": [[6, 25, 50, -1], [6, 25, 50, "All"]],
    // "iDisplayLength": 6,
    "bPaginate": false,
    responsive: true,
    //based one 2 column
    alphabetSearch: {
        column: 2
    }
});
$('.dataTables_length').addClass('bs-select');

//all Locations show hide
$('.all-Locations').hide();
$('.Locations-column .view').on('click', function () {
    $(this).closest('.Locations-column').find('.all-Locations').toggle();
});

//    check all checkbox
$('#select-all').click(function(event) {
    if(this.checked) {
        //disable edit link
        $("a.edit").attr("disabled", "disabled").addClass('disabled text-light');
        // Iterate each checkbox
        $(':checkbox').each(function() {
            this.checked = true;
        });
    } else {
        $(':checkbox').each(function() {
            this.checked = false;
        })
        //enable edit link
        $("a.edit").removeAttr("disabled").removeClass('disabled  text-light');
    }
});
$('#button').click( function () {
    table.row('.selected').remove().draw( false );
} );


//    disabled edit button on multi checkbox checked
var $checkboxes = $('td input[type="checkbox"]');
$checkboxes.change(function(){
    var countCheckedCheckboxes = $checkboxes.filter(':checked').length;
    if(countCheckedCheckboxes > 1){
        $("a.edit").attr("disabled", "disabled").addClass('disabled text-light');
        if (this.classList.contains('disabled')) {
            e.stopPropagation();
            e.preventDefault();
        }
    }
    else{
        $("a.edit").removeAttr("disabled").removeClass('disabled  text-light');
    }
});
//    //user edit location
$(".location-item .form-control").attr("disabled", "disabled");
$('.location-item .fa-edit').on('click', function () {
    console.log('clicked');
    $(this).closest(".location-item").find('input').removeAttr("disabled").focus();
});

//add more location list show
$('.available-locations .addMoreLocations').on('click', function () {
    $('.available-locations .nav').removeClass('hidden');
    $(this).addClass('hidden');
});

/*remove location added input*/
$(document).on("click", ".removeLocation", function() {
    $(this).parents('.location-item').remove();
});

//open edit modal
$('.edit').on('click', function () {
    var $checkboxes = $('td input[type="checkbox"]');
    var countCheckedCheckboxes = $checkboxes.filter(':checked').length;
    if(countCheckedCheckboxes === 1){
        $('#editUser').modal('show');
    }
});
$('.cancel').on('click', function () {
        $('.modal').modal('hide');
});

//tooltip initialization
$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})


/*keep tap active on reload*/
$('a[data-toggle="tab"]').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
});

$('a[data-toggle="tab"]').on("shown.bs.tab", function (e) {
    var id = $(e.target).attr("href");
    localStorage.setItem('selectedTab', id)
});

var selectedTab = localStorage.getItem('selectedTab');
if (selectedTab != null) {
    $('a[data-toggle="tab"][href="' + selectedTab + '"]').tab('show');
}
