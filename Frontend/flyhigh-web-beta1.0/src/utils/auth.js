export function parseToken(token) {
    if (!token) return null;
  
    const tokenParts = token.split('.');
    if (tokenParts.length !== 3) return null;
  
    try {
      const payload = JSON.parse(atob(tokenParts[1]));
      return payload;
    } catch (error) {
      console.error('Token parsing error:', error);
      return null;
    }
  }
  
  export function getUsername(payload) {
    if (!payload) return null;
    return payload.Names;
  }
  
  export function getPermissions(payload) {
    if (!payload) return null;
    return payload.Permissions;
  }

  export function logout(){
    localStorage.removeItem('token');      
    window.location.reload();  
 };
  