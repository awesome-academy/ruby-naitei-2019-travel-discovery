$( document ).ready(function() {
  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': csrfToken
    }
  });

  $('#add_data').click(function(){
    $('#name').val('');
  });

  $('#add').on('submit', function(event){
    event.preventDefault();
    var form_data = $(this).serialize();
    $.ajax({
        url: "/admin/cities",
        type: "POST",
        data: form_data,
        dataType: "json",
        success:function(data)
        {
          toastr["success"](I18n.t("admin.cities.index.add_success"), I18n.t("admin.cities.index.notification"));
          $('#add')[0].reset();
          $('#action').val('Add');
          $('#addcity').modal('hide');
          window.location.reload();
        }
    })
  });

  $(document).on('click','.edit',(function(){
    var id = $(this).attr('city-id');
    $.ajax({
      type: 'get',
      url: "/admin/cities/" + id + "/edit",
      dataType: "json",
      success:function(response){
        $('#form-edit').attr('data-id',response.id);
        $("input[name='name']").val(response.name);
      }
    })
  })
  );

  $('#form-edit').submit(function(e){
    e.preventDefault();
    var id = $(this).attr('data-id');
    $.ajax({
      type: 'put',
      url: "/admin/cities/" + id,
      data:{
        name: $('#name-edit').val(),
      },
      success:function(response){
        toastr["success"](I18n.t("admin.cities.index.edit_success"), I18n.t("admin.cities.index.notification"))
        $('#editcity').modal('hide');
      }
    })
  });

  $(document).on('click','.delete',(function(){
    var id = $(this).attr('city-id');
    swal({
      title: I18n.t("admin.cities.index.question"),
      text: I18n.t("admin.cities.index.note"),
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        $.ajax({
            type: 'delete',
            url: '/admin/cities/' +id,
        })
        swal(I18n.t("admin.cities.index.notice_true"), {
            icon: "success",
        });
        window.location.reload();
        } else {
          swal(I18n.t("admin.cities.index.notice_fails"));
        }
      });
    })
  );

});
