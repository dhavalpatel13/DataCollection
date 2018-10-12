using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace DataCollection.Models
{
    public class ContactUsViewModels
    {
        [MaxLength(50)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [MaxLength(10)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Emp No is required")]
        [MinLength(6, ErrorMessage = "Minimum 6 characters required")]
        public string EmpNo { get; set; }

        [MaxLength(50)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email is required")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [MaxLength(10)]
        [MinLength(10, ErrorMessage = "Minimum 10 number required")]
        [DataType(DataType.PhoneNumber)]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Mobile No is required")]
        public string MobileNo { get; set; }

        [MaxLength(100)]
        [DataType(DataType.MultilineText)]
        public string Subject { get; set; }

        [MaxLength(100)]
        [DataType(DataType.MultilineText)]
        public string Message { get; set; }
    }
}