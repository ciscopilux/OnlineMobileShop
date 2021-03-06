from flask import Flask, jsonify, request, send_file
from flask_cors import CORS
import MainAPI.ConnectSQL
import OtherFunctions.ExtraFunction
import Configuration.ConfigFlag


config_flag = Configuration.ConfigFlag
extra_function = OtherFunctions.ExtraFunction
connect = MainAPI.ConnectSQL.SqlFunction()
app = Flask(__name__)
CORS(app)


@app.route("/admin/insert-phone-type", methods=['POST'])
def insert_phone_type():
    try:
        name_phone_type = request.json['name_phone_type']
        if connect.insert_phone_type(name_phone_type):
            data = {'result': True, 'info': 'Thêm thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Thêm thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/insert-phone-color", methods=['POST'])
def insert_phone_color():
    try:
        color = request.json['color']
        if connect.insert_phone_color(color):
            data = {'result': True, 'info': 'Thêm thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Thêm thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/get-list-phone-type", methods=['GET'])
def get_list_phone_type():
    list_phone_type = connect.get_list_phone_type()
    return jsonify(list_phone_type)


@app.route("/admin/get-list-phone-color", methods=['GET'])
def get_list_phone_color():
    list_phone_type = connect.get_list_phone_color()
    return jsonify(list_phone_type)


@app.route("/admin/insert-phone", methods=['POST'])
def insert_phone():
    try:
        phone_name = request.json['phone_name']
        phone_type = request.json['phone_type']
        phone_description = request.json['phone_description']
        quantity = request.json['quantity']
        image = request.json['image']
        color = request.json['color']
        price = request.json['price']
        if connect.insert_phone(phone_name, phone_type, phone_description, quantity, image, color, price):
            data = {'result': True, 'info': 'Thêm thành công'}
            return jsonify(data)
        return jsonify({'result': True, 'info': 'Thêm thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/update-phone", methods=['POST'])
def update_phone():
    try:
        phone_name = request.json['phone_name']
        phone_type = request.json['phone_type']
        phone_description = request.json['phone_description']
        quantity = request.json['quantity']
        image = request.json['image']
        color = request.json['color']
        price = request.json['price']
        id_phone = request.json['id_phone']
        if connect.update_phone(phone_name, phone_type, phone_description, quantity, image, color, price, id_phone):
            data = {'result': True, 'info': 'Cập nhật thành công'}
            return jsonify(data)
        return jsonify({'result': True, 'info': 'Cập nhật thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/get-list-phone", methods=['GET'])
def get_list_phone():
    list_phone = connect.get_list_phone()
    return jsonify(list_phone)


@app.route("/admin/get-list-all-customer-order-by-date", methods=['POST'])
def get_list_all_customer_order_by_date():
    from_date = request.json['from_date']
    to_date = request.json['to_date']
    data = connect.get_list_all_order_customer(from_date, to_date)
    return jsonify(data)


@app.route("/admin/list-staff", methods=['GET'])
def get_list_staff():

    data = connect.get_list_staff()
    return jsonify(data)


@app.route("/admin/insert-role", methods=['POST'])
def insert_role():
    try:
        role_name = request.json['role_name']
        if connect.insert_role_staff(role_name):
            data = {'result': True, 'info': 'Thêm thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Thêm thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/list-role", methods=['GET'])
def get_list_role():
    list_role = connect.get_list_role()
    return jsonify(list_role)


@app.route("/admin/insert-staff", methods=['POST'])
def insert_staff():
    try:
        first_name = request.json['first_name']
        last_name = request.json['last_name']
        gender = request.json['gender']
        identity_card = request.json['identity_card']
        email = request.json['email']
        phone_num = request.json['phone_num']
        day_of_birth = request.json['date_of_birth']
        address = request.json['address']
        username = request.json['username']
        password = request.json['password']
        salary = request.json['salary']
        role = request.json['role_id']
        if connect.insert_staff(first_name, last_name, gender, identity_card, email, phone_num, day_of_birth,
                                address, username, password, salary, role):
            data = {'result': True, 'info': 'Thêm nhân viên thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Thêm nhân viên thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/update-staff", methods=['POST'])
def update_staff():
    try:
        role_id = request.json['role_id']
        salary = request.json['salary']
        staff_id = request.json['staff_id']
        if connect.update_staff(role_id, salary, staff_id):
            data = {'result': True, 'info': 'Sửa nhân viên thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Sửa thông tin nhân viên thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/delete-staff/<string:staff_id>", methods=['DELETE'])
def delete_staff(staff_id):
    try:
        if connect.delete_staff(staff_id):
            data = {'result': True, 'info': 'Xóa nhân viên thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Xóa nhân viên thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/staff/login", methods=['POST'])
def login_staff():
    try:
        username = request.json['username']
        password = request.json['password']
        if connect.check_login_staff(username, password):
            list_staff = connect.get_list_staff()
            for staff in list_staff:
                if staff['username'] == username:
                    data = {'result': True, 'info': staff, 'message': 'Đăng nhập thành công'}
                    return jsonify(data)
        return jsonify({'result': False, 'info': None, 'message': 'Sai tên đăng nhập hoặc mật khẩu'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': None, 'message': 'Có lỗi xảy ra'})


@app.route("/staff/change-password", methods=['POST'])
def change_password_staff():
    try:
        username = request.json['username']
        new_pass = request.json['new_pass']
        old_pass = request.json['old_pass']
        if connect.change_password_staff(username, old_pass, new_pass):
            return jsonify({'result': True, 'info': 'Đổi mật khẩu thành công'})
        return jsonify({'result': False, 'info': 'Đổi mật khẩu thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/reset-password", methods=['POST'])
def reset_password_staff():
    try:
        username = request.json['username']
        password = request.json['password']
        if connect.reset_password_staff(username, extra_function.hash_password(password)):
            return jsonify({'result': True, 'info': 'Cập nhật mật khẩu cho nhân viên thành công'})
        return jsonify({'result': False, 'info': 'Cập nhật mật khẩu thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/staff/show-info/<string:staff_id>", methods=['GET'])
def show_info_staff_by_id(staff_id):
    try:
        list_staff = connect.get_list_staff()
        for staff in list_staff:
            if staff['id'] == staff_id:
                return jsonify(staff)
        return jsonify()
    except Exception as ex:
        print(ex)
        return jsonify()


@app.route("/person/change-info", methods=['POST'])
def change_info_person():
    try:
        first_name = request.json['first_name']
        last_name = request.json['last_name']
        gender = request.json['gender']
        identity_card = request.json['identity_card']
        email = request.json['email']
        phone_num = request.json['phone_num']
        dob = request.json['day_of_birth']
        address = request.json['address']
        id_person = request.json['id_customer']
        if connect.update_info(first_name, last_name, gender, identity_card, email, phone_num, dob, address, id_person):
            return jsonify({'result': True, 'info': 'Cập nhật thông tin cá nhân thành công'})
        return jsonify({'result': False, 'info': 'Cập nhật thông tin thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/admin/list-customer", methods=['GET'])
def get_list_customer():
    data = connect.get_list_customer()
    return jsonify(data)


@app.route("/customer/login", methods=['POST'])
def login_customer():
    try:
        username = request.json['username']
        password = request.json['password']
        if connect.check_login_customer(username, password):
            list_customer = connect.get_list_customer()
            for customer in list_customer:
                if customer['username'] == username:
                    data = {'result': True, 'info': customer, 'message': 'Đăng nhập thành công'}
                    return jsonify(data)
        return jsonify({'result': False, 'info': None, 'message': 'Sai tên đăng nhập hoặc mật khẩu'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': None, 'message': 'Có lỗi xảy ra'})


@app.route("/customer/show-info/<string:customer_id>")
def show_info_customer_by_id(customer_id):
    try:
        list_customer = connect.get_list_customer()
        for customer in list_customer:
            if customer['id'] == customer_id:
                return jsonify(customer)
        return jsonify()
    except Exception as ex:
        print(ex)
        return jsonify()


@app.route("/customer/change-password", methods=['POST'])
def change_password_customer():
    try:
        username = request.json['username']
        old_pass = request.json['old_pass']
        new_pass = request.json['new_pass']
        if connect.change_password_customer(username, old_pass, new_pass):
            data = {'result': True, 'info': 'Đổi mật khẩu thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Đổi mật khẩu thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/customer/send-verify-reset-password", methods=['POST'])
def send_verify_reset_password():
    try:
        email = request.json['email']
        username = request.json['username']
        if connect.get_customer_email_by_username(username) == email:
            verify_number = extra_function.send_mail(email, config_flag.signal_message_reset_password)
            data = {'email': email, 'verify_number': verify_number}
            return jsonify({'result': True, 'info': 'Chuyển sang trang xác thực', 'data': data})
        else:
            return jsonify({'result': False, 'info': 'Sai email hoặc tài khoản', 'data': None})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra', 'data': None})


@app.route("/customer/check-verify-reset-password", methods=['POST'])
def check_verify_reset_password():
    try:
        verify_number_input = request.json['verify_number_input']
        verify_number_session = request.json['verify_number_session']
        if verify_number_session == verify_number_input:
            return jsonify({'result': True, 'info': 'Mã xác thực đúng'})
        else:
            return jsonify({'result': False, 'info': 'Mã xác thực sai'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/customer/reset-password", methods=['POST'])
def reset_password_customer():
    user_name = request.json["username"]
    password = request.json["password"]
    if connect.reset_password_customer(user_name, extra_function.hash_password(password)):
        return jsonify({'result': True, 'info': 'Đổi mật khẩu thành công'})
    return jsonify({'result': False, 'info': 'Đổi mật khẩu thất bại'})


@app.route("/customer/register", methods=['POST'])
def register_customer():
    try:
        first_name = request.json['first_name']
        last_name = request.json['last_name']
        gender = request.json['gender']
        identity_card = request.json['identity_card']
        email = request.json['email']
        phone_num = request.json['phone_num']
        dob = request.json['date_of_birth']
        address = request.json['address']
        username = request.json['username']
        password = request.json['password']
        # If insert success =>> new customer
        if connect.insert_customer(first_name, last_name, gender, identity_card, email, phone_num, dob,
                                   address, username, password):
            # list_customer = connect.get_list_customer()
            # for customer in list_customer:
            #     if customer['username'] == username:
            #         data = {'result': True, 'info': customer}
            #         return jsonify(data)
            verify_number = extra_function.send_mail(email, config_flag.signal_message_active_account)
            active_account = {'email': email, 'verify_number': verify_number}
            data = {'result': True, 'info': 'Đăng ký thành công', 'data': active_account}
            return jsonify(data)
        else:
            data = {}
            list_customer = connect.get_list_customer()
            for customer in list_customer:
                if customer['phone_num'] == phone_num:
                    data['result'] = False
                    data['info'] = 'Số điện thoại đã được sử dụng'
                    data['data'] = None
                    return jsonify(data)
                if customer['email'] == email:
                    data['result'] = False
                    data['info'] = 'Email đã được sử dụng'
                    data['data'] = None
                    return jsonify(data)
            return jsonify({'result': False, 'info': 'Có lỗi xảy ra', 'data': None})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Đăng kí thất bại', 'data': None})


@app.route("/customer/active-account", methods=['POST'])
def active_customer_account():
    try:
        email = request.json['email']
        verify_number_input = request.json['verify_number_input']
        verify_number_session = request.json['verify_number_session']
        if verify_number_session == verify_number_input:
            connect.active_customer(email)
            return jsonify({'result': True, 'info': 'Xác thực tài khoản thành công'})
        return jsonify({'result': False, 'info': 'Xác thực tài khoản thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/customer/insert-order", methods=['POST'])
def insert_customer_order():
    try:
        customer_id = request.json['customer_id']
        address = request.json['address']
        note = request.json['note']
        phone_id_list = request.json['phone_id_list']
        quantity_list = request.json['quantity_list']
        price_list = request.json['price_list']
        if connect.insert_customer_order(customer_id, address, None, note, phone_id_list, quantity_list, price_list):
            data = {'result': True, 'info': 'Đặt hàng thành công'}
            return jsonify(data)
        else:
            data = {'result': False, 'info': 'Đặt hàng thất bại'}
            return jsonify(data)
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Đặt hàng thất bại'})


@app.route("/customer/check-history-order/<string:customer_id>", methods=['GET'])
def get_list_history_customer_order(customer_id):
    try:
        # customer_id = request.json['customer_id']
        data = connect.get_list_history_order_customer(customer_id)
        return jsonify({'result': True, 'info': data, 'message': 'Lấy danh sách mua hàng thành công'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': [], 'message': 'Có lỗi xảy ra'})


@app.route("/staff/update-order", methods=['POST'])
def update_customer_order():
    try:
        staff_id = request.json['staff_id']
        order_id = request.json['order_id']
        status_id = request.json['status_id']
        if connect.update_customer_order(order_id, staff_id, status_id):
            data = {'result': True, 'info': 'Cập nhật thành công'}
            return jsonify(data)
        return jsonify({'result': False, 'info': 'Cập nhật thất bại'})
    except Exception as ex:
        print(ex)
        return jsonify({'result': False, 'info': 'Có lỗi xảy ra'})


@app.route("/get-image/<string:id_image>", methods=['GET'])
def get_image(id_image):
    return send_file("D:\\CODE\\Project_python\\MobileShop\\Image\\{}".format(id_image), mimetype='image/gif')


if __name__ == '__main__':
    app.run(port=5000)
