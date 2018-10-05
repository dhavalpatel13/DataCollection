using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DataCollection.Models
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }
    }

    public class ManageUserViewModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "New password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password")]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class LoginViewModel
    {
        [Required(ErrorMessage="UserId is Required")]
        [Display(Name = "UserId")]
        public string UserId { get; set; }

        [Required(ErrorMessage = "Password is Required")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [Display(Name = "Remember me?")]
        public bool RememberMe { get; set; }
    }

    public class RegisterViewModel
    {
        //[Required]
        //[Display(Name = "User name")]
        //public string UserName { get; set; }

        //[Required]
        //[StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        //[DataType(DataType.Password)]
        //[Display(Name = "Password")]
        //public string Password { get; set; }

        //[DataType(DataType.Password)]
        //[Display(Name = "Confirm password")]
        //[Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        //public string ConfirmPassword { get; set; }

        [MaxLength(20)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "UserId is required")]
        public string UserId { get; set; }

        [MaxLength(50)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "User name is required")]
        public string UserName { get; set; }

        [MaxLength(10)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Emp No is required")]
        [MinLength(6, ErrorMessage = "Minimum 6 characters required")]
        public string UserEmpNo { get; set; }

        [MaxLength(50)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email is required")]
        [DataType(DataType.EmailAddress)]
        public string UserEmail { get; set; }

        [MaxLength(20)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        [MinLength(6, ErrorMessage = "Minimum 6 characters required")]
        public string UserPassword { get; set; }

        [MaxLength(20)]
        [Display(Name = "Confirm Password")]
        [DataType(DataType.Password)]
        [Compare("UserPassword", ErrorMessage = "Confirm password and password do not match")]
        public string ConfirmUserPassword { get; set; }

        [MaxLength(10)]
        [MinLength(10, ErrorMessage = "Minimum 10 number required")]
        [DataType(DataType.PhoneNumber)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Mobile No is required")]
        public string MobileNo { get; set; }

        [MaxLength(100)]
        [DataType(DataType.MultilineText)]
        public string UserRemarks { get; set; }

        public string UserWork { get; set; }

        public string DeptID { get; set; }
        
        public IEnumerable<System.Web.Mvc.SelectListItem> UserWorkDDLList { get; set; }

        public IEnumerable<System.Web.Mvc.SelectListItem> DeptDDLList { get; set; }
    }

    public class ResetPasswordModel
    {
        [Required(ErrorMessage = "New password is required", AllowEmptyStrings = false)]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Confirm password is required", AllowEmptyStrings = false)]
        [Compare("NewPassword", ErrorMessage = "New password and confirm password does not match")]
        public string ConfirmPassword { get; set; }

        [Required]
        public string ResetCode { get; set; }
    }
}
