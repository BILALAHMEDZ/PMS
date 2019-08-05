# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_805_060_253) do
  create_table 'clients', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'phone'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'comments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'message'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'employees_projects', id: false, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'project_id', null: false
    t.bigint 'employee_id', null: false
  end

  create_table 'payments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.decimal 'payment', precision: 10
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'project_id'
    t.bigint 'creater_id'
    t.index ['creater_id'], name: 'index_payments_on_creater_id'
    t.index ['project_id'], name: 'index_payments_on_project_id'
  end

  create_table 'projects', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.integer 'hours_spent'
    t.decimal 'amount', precision: 10
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'client_id'
    t.bigint 'creater_id'
    t.bigint 'manager_id'
    t.index ['client_id'], name: 'index_projects_on_client_id'
    t.index ['creater_id'], name: 'index_projects_on_creater_id'
    t.index ['manager_id'], name: 'index_projects_on_manager_id'
  end

  create_table 'timelogs', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'hours'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'employee_id'
    t.bigint 'project_id'
    t.index ['employee_id'], name: 'index_timelogs_on_employee_id'
    t.index ['project_id'], name: 'index_timelogs_on_project_id'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'encrypted_password', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'status'
    t.string 'type'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'payments', 'projects'
  add_foreign_key 'projects', 'clients'
end
