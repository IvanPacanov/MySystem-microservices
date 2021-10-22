CREATE VIEW dbo.SVW_UserFriends
AS
SELECT 
    [user].Id,
    friend.UserId
FROM 
    dbo.AboutUser [user]
JOIN 
   [dbo].[Friends] friend on friend.UserId = [user].Id