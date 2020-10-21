//
//  String.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/19/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension App {
    struct String {
        static let error = "Lỗi"
        static let ok = "OK"
        static let cancel = "Cancel"
    }
    struct ErrorBooking {
        static let errorTime = "Sai Khung Giờ"
        static let chooseTime = "Chọn Lại Khung Giờ"
        static let minHours = "Vui lòng chọn trước 9h tối và sau 6h sáng"
        static let minDay = "Vui lòng đặt trước ít nhất 1 ngày"
        static let bookingthePitch = "Đặt Sân"
        static let statusBooking = "Tình Trạng"
        static let errorBooking = "Lỗi Đặt Sân"
        static let errorInforBooking = "Lỗi"
    }
    
    struct Login {
        static let errorLogin = "Lỗi Đăng Nhập"
        static let messLogin = "Nhập lại mật khẩu hoặc số điện thoại"
        static let error = "Lỗi"
    }
    
    struct Favorite {
        static let errorFavorite = "Lỗi Yêu Thích"
        static let noFavorite = "Không Có Sân Yêu Thích!"
        static let title = "Sân Yêu Thích"
        static let warningDelete = "Cảnh Báo"
        static let deleteAll = "Xóa Tất Cả"
    }
    
    struct Schedule {
        static let isEmptySchedule = "Không Có Lịch Đặt Sân!"
        static let booked = "Lịch Đã Được Đặt"
        static let cancelTitle = "Hủy"
        static let cancelBooking = "Hủy Sân"
        
    }
}
