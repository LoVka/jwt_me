require 'bundler/setup'
require 'clipboard'

RSpec.describe 'jwt_me' do
  before { Clipboard.clear }
  let(:jwt_me) { File.join(File.expand_path(File.join('..', '..'), __FILE__), 'jwt_me') }

  it 'copies JWT to clipboard when valid min params' do
    $stdin = StringIO.new "user_id\n1234\nemail\ntest@text.ua\nno"
    load jwt_me
    expect(Clipboard.paste).to eq('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTIzNCIsImVtYWlsIjoidGVzdEB0ZXh0LnVhIn0.M3EGVYeHaD2J8T_jXKo2xYI2B6gx6yyxjgU0t6EjxVg')
  end

  it 'requires user_id and email' do
    $stdin = StringIO.new "key1\n1234\nkey2\nval2\nno"
    expect { load jwt_me }.to raise_error SystemExit, 'User_id is requered, Email is requered'
  end

  it 'requires user_id when valid email' do
    $stdin = StringIO.new "key1\n1234\nemail\ntest@text.ua\nno"
    expect { load jwt_me }.to raise_error SystemExit, 'User_id is requered'
  end

  it 'requires valid email' do
    $stdin = StringIO.new "user_id\n1234\nemail\ntest\ntest@tuto.dd\nno"
    load jwt_me
    expect(Clipboard.paste).to eq('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTIzNCIsImVtYWlsIjoidGVzdEB0dXRvLmRkIn0.a24OBBvgqvhkS8t7pF1NY9VmAf3_Q_CuEFbRfuLdXss')
  end

  it 'copies JWT to clipboard with some extra params' do
    $stdin = StringIO.new "user_id\n1234\nemail\ntest@tuto.dd\nyes\nname\nBen"
    load jwt_me
    expect(Clipboard.paste).to eq('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTIzNCIsImVtYWlsIjoidGVzdEB0dXRvLmRkIn0.a24OBBvgqvhkS8t7pF1NY9VmAf3_Q_CuEFbRfuLdXss')
  end
end
