class Post < ApplicationRecord
    after_create_commit -> {broadcast_prepend_to "posts", partial: "posts/post", locals: { post: self }, target: "posts"}
    after_update_commit -> {broadcast_update_to "posts", partial: "posts/post", locals: {post: self}, target: self}
    after_destroy_commit -> {broadcast_remove_to "posts", target: self}
end
