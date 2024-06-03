
{{ config(
    tags = ['RND']
) }}


with 
      source_data as (

     select cast(work.id as int64)                              as worklog_id,
            cast(issueId as int64)                              as issue_id,
            issue.key                                           as key,
            work.self                                           as worklog_self,
            json_extract_scalar(author, '$.accountId')          as author_account_id,
            json_extract_scalar(author, '$.displayName')        as author_display_name,
            json_extract_scalar(author, '$.emailAddress')       as author_email_address,
            json_extract_scalar(updateAuthor, '$.accountId')    as update_author_account_id,
            json_extract_scalar(updateAuthor, '$.displayName')  as update_author_display_name,
            json_extract_scalar(updateAuthor, '$.emailAddress') as update_author_email_address,
            created                                             as created,
            updated                                             as updated,
            started                                             as started, 
            timeSpent                                           as time_spent,
            timeSpentSeconds                                    as time_spent_seconds,
            timeSpentSeconds / 60                               as time_spent_in_minutes,
            work.row_insert_ts                                  as row_insert_ts           
      from {{ source('jira', 'worklogs') }}  work
 left join {{ source('jira', 'issues') }}  issue
        on cast(work.issueId as int64) = issue.id
)

select * from source_data

